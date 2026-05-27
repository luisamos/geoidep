from flask import Blueprint, flash, jsonify, redirect, render_template, request, url_for
from flask_jwt_extended import jwt_required, unset_jwt_cookies
from sqlalchemy import func, or_
from sqlalchemy.orm import joinedload

from app.extensions import db
from app.forms import BuscarUsuarioForm, DeleteUsuarioForm, UsuarioForm
from app.models import Institucion
from app.models import Perfil
from app.models import Persona, Usuario
from .helpers import obtener_usuario_actual, usuario_restringido_a_su_entidad

bp = Blueprint('usuarios', __name__, url_prefix='/usuarios')

EXCLUDED_PARENT_IDS = tuple(range(10))

def redirect_to_login():
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta

def obtener_admin_actual():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return None, redirect_to_login()
  if not usuario.es_coordinador:
    flash('No cuentas con permisos para acceder a esta sección.', 'error')
    return None, redirect(url_for('monitoreos.principal'))
  return usuario, None

def obtener_instituciones_para(usuario: Usuario):
  consulta = Institucion.query
  if usuario_restringido_a_su_entidad(usuario):
    consulta = consulta.filter(Institucion.id == usuario.id_institucion)
  else:
    consulta = consulta.filter(~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS))
  return consulta.order_by(Institucion.id.asc()).all()

@bp.route('/', endpoint='listar')
@jwt_required()
def usuarios():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return redirect_to_login()

  instituciones = obtener_instituciones_para(usuario)
  instituciones_json = [
    {'id': inst.id, 'nombre': inst.nombre or '', 'sigla': inst.sigla or ''}
    for inst in instituciones
  ]

  perfiles = Perfil.query.order_by(Perfil.id.asc()).all()

  return render_template(
    'gestion/usuarios.html',
    instituciones=instituciones_json,
    perfiles=perfiles,
    usuario_actual=usuario,
  )


@bp.route('/datos', endpoint='datos')
@jwt_required()
def datos_usuarios():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return jsonify({'status': 'error', 'message': 'Sin acceso.'}), 403

  consulta = (
    Usuario.query.options(
      joinedload(Usuario.persona),
      joinedload(Usuario.perfil),
      joinedload(Usuario.institucion),
    )
    .join(Persona, Usuario.persona)
    .order_by(
      func.coalesce(Persona.nombres_apellidos, ''),
      Usuario.correo_electronico,
    )
  )
  if usuario_restringido_a_su_entidad(usuario):
    consulta = consulta.filter(Usuario.id_institucion == usuario.id_institucion)

  lista = [
    {
      'id': u.id,
      'nombre_completo': u.nombre_completo or '',
      'correo_electronico': u.correo_electronico or '',
      'cargo': u.cargo or '',
      'id_perfil': u.id_perfil,
      'perfil_nombre': u.perfil.nombre if u.perfil else '',
      'id_institucion': u.id_institucion,
      'institucion_nombre': u.institucion.nombre if u.institucion else '',
      'institucion_sigla': u.institucion.sigla if u.institucion else '',
      'cnd': u.cnd,
      'idep': u.idep,
      'geoperu': u.geoperu,
      'pnda': u.pnda,
      'cnm': u.cnm,
      'estado': u.estado,
    }
    for u in consulta.all()
  ]
  return jsonify({'usuarios': lista})

def _aplicar_campos_usuario(usuario, payload, admin_id):
  """Aplica los campos del payload JSON a la instancia de Usuario."""
  nombres = (payload.get('nombres_apellidos') or '').strip() or None
  if nombres is not None and usuario.persona:
    usuario.persona.nombres_apellidos = nombres
  usuario.cargo         = (payload.get('cargo') or '').strip() or None
  usuario.id_institucion = int(payload['id_institucion'])
  usuario.id_perfil      = int(payload['id_perfil'])
  usuario.estado         = bool(payload.get('estado', True))
  usuario.cnd            = bool(payload.get('cnd', False))
  usuario.idep           = bool(payload.get('idep', False))
  usuario.geoperu        = bool(payload.get('geoperu', False))
  usuario.pnda           = bool(payload.get('pnda', False))
  usuario.cnm            = bool(payload.get('cnm', False))

@bp.route('/guardar', methods=['POST'], endpoint='guardar')
@jwt_required()
def guardar_usuario():
  admin, respuesta = obtener_admin_actual()
  if respuesta:
    return respuesta

  payload = request.get_json(silent=True) or {}
  nombres_apellidos = (payload.get('nombres_apellidos') or '').strip()
  correo = (payload.get('correo_electronico') or '').strip().lower()
  password = (payload.get('password') or '').strip()

  if not nombres_apellidos or not correo:
    return jsonify({'status': 'error', 'message': 'El nombre y el correo son obligatorios.'}), 400
  if not payload.get('id_institucion') or not payload.get('id_perfil'):
    return jsonify({'status': 'error', 'message': 'Institución y perfil son obligatorios.'}), 400
  if not password:
    return jsonify({'status': 'error', 'message': 'Ingrese una contraseña para el nuevo usuario.'}), 400
  if Usuario.query.filter(func.lower(Usuario.correo_electronico) == correo).first():
    return jsonify({'status': 'error', 'message': 'El correo electrónico ya está registrado.'}), 400

  persona = Persona(nombres_apellidos=nombres_apellidos, usuario_registro=admin.id)
  usuario = Usuario(correo_electronico=correo, usuario_registro=admin.id, contrasena='')
  usuario.persona = persona
  db.session.add(persona)
  db.session.add(usuario)
  _aplicar_campos_usuario(usuario, payload, admin.id)
  usuario.set_password(password)
  db.session.commit()
  return jsonify({'status': 'success', 'message': 'Usuario creado correctamente.'})

@bp.route('/<int:id_usuario>', methods=['PUT'], endpoint='actualizar')
@jwt_required()
def actualizar_usuario(id_usuario: int):
  admin, respuesta = obtener_admin_actual()
  if respuesta:
    return respuesta

  usuario = Usuario.query.options(joinedload(Usuario.persona)).filter_by(id=id_usuario).first()
  if not usuario:
    return jsonify({'status': 'error', 'message': 'Usuario no encontrado.'}), 404

  payload = request.get_json(silent=True) or {}
  correo = (payload.get('correo_electronico') or '').strip().lower()

  if correo and correo != usuario.correo_electronico:
    if Usuario.query.filter(func.lower(Usuario.correo_electronico) == correo).filter(Usuario.id != id_usuario).first():
      return jsonify({'status': 'error', 'message': 'El correo ya está asociado a otro usuario.'}), 400
    usuario.correo_electronico = correo

  _aplicar_campos_usuario(usuario, payload, admin.id)

  password = (payload.get('password') or '').strip()
  if password:
    usuario.set_password(password)

  db.session.commit()
  return jsonify({'status': 'success', 'message': 'Usuario actualizado correctamente.'})

@bp.route('/<int:id_usuario>/eliminar', methods=['POST'], endpoint='eliminar')
@jwt_required()
def eliminar_usuario(id_usuario: int):
  admin, respuesta = obtener_admin_actual()
  if respuesta:
      return respuesta

  form = DeleteUsuarioForm()
  if not form.validate_on_submit():
    flash('No se pudo validar la solicitud de eliminación.', 'error')
    return redirect(url_for('usuarios.listar'))

  if id_usuario == 1:
    flash('No es posible eliminar la cuenta principal de administrador.', 'error')
    return redirect(url_for('usuarios.listar'))

  usuario = Usuario.query.options(joinedload(Usuario.persona)).get_or_404(id_usuario)
  if usuario.id_persona == 1:
    flash('No es posible eliminar la persona asociada al administrador.', 'error')
    return redirect(url_for('usuarios.listar'))

  db.session.delete(usuario)
  db.session.commit()
  flash('Usuario eliminado correctamente.', 'success')
  return redirect(url_for('usuarios.listar'))
from flask import Blueprint, flash, jsonify, redirect, render_template, request, url_for
from flask_jwt_extended import jwt_required
from sqlalchemy import func, or_
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from app.extensions import db
from app.forms import BuscarUsuarioForm, DeleteUsuarioForm, UsuarioForm
from app.models import Perfil
from app.models import Persona, Rol, Usuario, UsuarioRol
from app.services.instituciones import obtener_instituciones_para
from .helpers import (
  obtener_usuario_actual,
  redirect_to_login,
  usuario_puede_editar,
  usuario_restringido_a_su_entidad,
)

bp = Blueprint('usuarios', __name__, url_prefix='/usuarios')


def obtener_admin_actual():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return None, redirect_to_login()
  if usuario_restringido_a_su_entidad(usuario):
    flash('No cuentas con permisos para acceder a esta sección.', 'error')
    return None, redirect(url_for('monitoreos.principal'))
  return usuario, None

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
  if not usuario_puede_editar(admin):
    return jsonify({'status': 'error', 'message': 'No cuentas con permisos de escritura.'}), 403

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
  if not usuario_puede_editar(admin):
    return jsonify({'status': 'error', 'message': 'No cuentas con permisos de escritura.'}), 403

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

@bp.route('/<int:id_usuario>/roles/datos', methods=['GET'], endpoint='roles_datos')
@jwt_required()
def obtener_roles_usuario(id_usuario: int):
  admin, respuesta = obtener_admin_actual()
  if respuesta:
    return respuesta

  if not Usuario.query.get(id_usuario):
    return jsonify({'status': 'error', 'message': 'Usuario no encontrado.'}), 404

  todos = Rol.query.all()
  padres = {r.id: r for r in todos if r.id_padre == 0}

  def clave_orden(r: Rol):
    padre = padres.get(r.id_padre)
    return (
      padre.orden if padre else 999,
      (padre.nombre or '') if padre else '',
      r.orden,
      r.nombre or '',
    )

  hijos = sorted([r for r in todos if r.id > 6], key=clave_orden)

  asignaciones = UsuarioRol.query.filter(UsuarioRol.id_usuario == id_usuario).all()
  asignados = {int(a.id_rol): int(a.nivel) for a in asignaciones}

  disponibles = [
    {
      'id': r.id,
      'nombre': r.nombre or '',
      'orden': r.orden,
      'id_padre': r.id_padre,
      'padre_nombre': (padres[r.id_padre].nombre or '') if r.id_padre in padres else '',
      'padre_orden': padres[r.id_padre].orden if r.id_padre in padres else 999,
    }
    for r in hijos
  ]
  return jsonify({'disponibles': disponibles, 'asignados': asignados})


@bp.route('/<int:id_usuario>/roles', methods=['POST'], endpoint='asignar_roles')
@jwt_required()
def asignar_roles_usuario(id_usuario: int):
  admin, respuesta = obtener_admin_actual()
  if respuesta:
    return respuesta
  if not usuario_puede_editar(admin):
    return jsonify({'status': 'error', 'message': 'No cuentas con permisos de escritura.'}), 403

  if not Usuario.query.get(id_usuario):
    return jsonify({'status': 'error', 'message': 'Usuario no encontrado.'}), 404

  payload = request.get_json(silent=True) or {}
  roles_payload = payload.get('roles') or []

  ids_validos = {r.id for r in Rol.query.filter(Rol.id > 6).all()}
  asignaciones_nuevas = []
  for item in roles_payload:
    try:
      id_rol = int(item.get('id_rol'))
      nivel = int(item.get('nivel'))
    except (TypeError, ValueError, AttributeError):
      continue
    if id_rol not in ids_validos or nivel not in (1, 2):
      continue
    asignaciones_nuevas.append((id_rol, nivel))

  UsuarioRol.query.filter(UsuarioRol.id_usuario == id_usuario).delete()
  for id_rol, nivel in asignaciones_nuevas:
    db.session.add(UsuarioRol(
      id_usuario=id_usuario,
      id_rol=id_rol,
      nivel=nivel,
      usuario_registro=admin.id,
    ))

  try:
    db.session.commit()
  except IntegrityError:
    db.session.rollback()
    return jsonify({'status': 'error', 'message': 'No se pudieron asignar los roles.'}), 400

  return jsonify({'status': 'success', 'message': 'Roles asignados correctamente.'})


@bp.route('/<int:id_usuario>/eliminar', methods=['POST'], endpoint='eliminar')
@jwt_required()
def eliminar_usuario(id_usuario: int):
  admin, respuesta = obtener_admin_actual()
  if respuesta:
      return respuesta
  if not usuario_puede_editar(admin):
    flash('No cuentas con permisos de escritura.', 'error')
    return redirect(url_for('usuarios.listar'))

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
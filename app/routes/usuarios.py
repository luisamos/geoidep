from flask import Blueprint, flash, jsonify, redirect, render_template, request, url_for
from flask_jwt_extended import jwt_required, unset_jwt_cookies
from sqlalchemy import func, or_
from sqlalchemy.orm import joinedload

from app.extensions import db
from app.forms import BuscarUsuarioForm, DeleteUsuarioForm, UsuarioForm
from app.models import Institucion
from app.models import Perfil
from app.models import Persona, Usuario
from .helpers import obtener_usuario_actual

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
    return None, redirect(url_for('gestion.principal'))
  return usuario, None

def obtener_instituciones_para(usuario: Usuario):
  consulta = Institucion.query
  if usuario.es_gestor:
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
    seccion_activa='rol14',
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
      'geoidep': u.geoidep,
      'geoperu': u.geoperu,
      'estado': u.estado,
    }
    for u in consulta.all()
  ]
  return jsonify({'usuarios': lista})

@bp.route('/guardar', methods=['POST'], endpoint='guardar')
@jwt_required()
def guardar_usuario():
  admin, respuesta = obtener_admin_actual()
  if respuesta:
    return respuesta

  instituciones = obtener_instituciones_para(admin)
  choices_institucion = [(inst.id, inst.nombre) for inst in instituciones]

  perfiles = (
    Perfil.query.filter_by(estado=True)
    .order_by(Perfil.id.asc())
    .all()
  )
  choices_perfil = [(perfil.id, perfil.nombre) for perfil in perfiles]

  form = UsuarioForm()
  form.id_institucion.choices = choices_institucion
  form.id_perfil.choices = choices_perfil

  if form.validate_on_submit():
    email = form.email.data.strip().lower()
    usuario = None
    if form.id.data:
      usuario = (
        Usuario.query.options(joinedload(Usuario.persona))
        .filter_by(id=int(form.id.data))
        .first_or_404()
      )
      existe = (
        Usuario.query.filter(func.lower(Usuario.correo_electronico) == email)
        .filter(Usuario.id != usuario.id)
        .first()
      )
      if existe:
        flash('El correo electrónico ya está asociado a otro usuario.', 'error')
        return redirect(url_for('usuarios.listar', editar=usuario.id))
  else:
    if Usuario.query.filter(func.lower(Usuario.correo_electronico) == email).first():
      flash('El correo electrónico ya está registrado.', 'error')
      return redirect(url_for('usuarios.listar'))
    if not form.password.data:
      flash('Debes ingresar una contraseña para el nuevo usuario.', 'error')
      return redirect(url_for('usuarios.listar'))
    usuario = Usuario(correo_electronico=email)
    usuario.usuario_registro = admin.id
    persona = Persona(
      nombres=form.nombres.data.strip() or None,
      apellidos=form.apellidos.data.strip() or None,
      numero_documento=form.numero_documento.data.strip() or None,
      usuario_registro=admin.id,
    )
    usuario.persona = persona
    db.session.add(persona)
    db.session.add(usuario)

    usuario.email = email
    usuario.nombres = form.nombres.data
    usuario.apellidos = form.apellidos.data
    usuario.numero_documento = form.numero_documento.data
    usuario.id_institucion = form.id_institucion.data
    usuario.id_perfil = form.id_perfil.data
    usuario.estado = form.estado.data
    usuario.geoidep = form.geoidep.data
    usuario.geoperu = form.geoperu.data

    if usuario.persona:
      usuario.persona.usuario_registra = admin.id
    if form.password.data:
      usuario.set_password(form.password.data)

    db.session.commit()
    flash('Usuario guardado correctamente.', 'success')
    return redirect(url_for('usuarios.listar'))

  for campo, errores in form.errors.items():
    etiqueta = getattr(form, campo).label.text
    for error in errores:
      flash(f"{etiqueta}: {error}", 'error')

  return redirect(url_for('usuarios.listar'))

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
from flask import Blueprint, flash, redirect, render_template, request, url_for
from flask_jwt_extended import jwt_required, unset_jwt_cookies
from sqlalchemy import func, or_
from sqlalchemy.orm import joinedload

from extensions import db
from forms.autenticacion import BuscarUsuarioForm, DeleteUsuarioForm, UsuarioForm
from models.instituciones import Institucion
from models.perfiles import Perfil
from models.usuarios import Persona, Usuario
from routes._helpers import obtener_usuario_actual

bp = Blueprint('usuarios', __name__, url_prefix='/usuarios')


def redirect_to_login():
  respuesta = redirect(url_for('gestion.ingreso'))
  unset_jwt_cookies(respuesta)
  return respuesta

def obtener_admin_actual():
  usuario = obtener_usuario_actual(requerido=True)
  if not usuario:
    return None, _redirect_to_login()
  if not usuario.es_administrador:
    flash('No cuentas con permisos para acceder a esta sección.', 'error')
    return None, redirect(url_for('gestion.principal'))
  return usuario, None

def obtener_instituciones_para(usuario: Usuario):
  consulta = Institucion.query.order_by(Institucion.nombre.asc())
  if usuario.es_gestor:
    consulta = consulta.filter(Institucion.id == usuario.id_institucion)
  return consulta.all()

@bp.route('/', endpoint='listar')
@jwt_required()
def usuarios():
  admin, respuesta = obtener_admin_actual()
  if respuesta:
    return respuesta

  termino = request.args.get('q', '').strip()
  editar_id = request.args.get('editar', type=int)

  consulta = (
    Usuario.query.options(
      joinedload(Usuario.persona),
      joinedload(Usuario.perfil),
      joinedload(Usuario.institucion),
    )
    .join(Persona, Usuario.persona)
    .order_by(
      func.coalesce(Persona.apellidos, ''),
      func.coalesce(Persona.nombres, ''),
      Usuario.correo_electronico,
    )
  )

  if termino:
    termino_like = f"%{termino.lower()}%"
    consulta = consulta.filter(
      or_(
        func.lower(Persona.nombres).like(termino_like),
        func.lower(Persona.apellidos).like(termino_like),
        func.lower(Persona.numero_documento).like(termino_like),
        func.lower(Usuario.correo_electronico).like(termino_like),
      )
    )

  lista_usuarios = consulta.all()

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

  if choices_institucion and not form.id.data:
    form.id_institucion.data = choices_institucion[0][0]
  if choices_perfil and not form.id.data:
    form.id_perfil.data = choices_perfil[0][0]

  usuario_editar = None
  if editar_id:
    usuario_editar = (
      Usuario.query.options(joinedload(Usuario.persona))
      .filter_by(id=editar_id)
      .first_or_404()
    )
    form = UsuarioForm()
    form.id.data = str(usuario_editar.id)
    form.nombres.data = usuario_editar.nombres or ''
    form.apellidos.data = usuario_editar.apellidos or ''
    form.numero_documento.data = usuario_editar.numero_documento or ''
    form.email.data = usuario_editar.email
    form.estado.data = usuario_editar.estado
    form.geoidep.data = usuario_editar.geoidep
    form.geoperu.data = usuario_editar.geoperu
    form.id_institucion.choices = choices_institucion
    form.id_perfil.choices = choices_perfil
    form.id_institucion.data = usuario_editar.id_institucion
    form.id_perfil.data = usuario_editar.id_perfil

  buscar_form = BuscarUsuarioForm()
  buscar_form.termino.data = termino
  delete_form = DeleteUsuarioForm()

  return render_template(
    'gestion/usuarios.html',
    usuarios=lista_usuarios,
    form=form,
    buscar_form=buscar_form,
    delete_form=delete_form,
    usuario_editar=usuario_editar,
    termino=termino,
  )

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
    usuario.usuario_crea = admin.id
    persona = Persona(
      nombres=form.nombres.data.strip() or None,
      apellidos=form.apellidos.data.strip() or None,
      numero_documento=form.numero_documento.data.strip() or None,
      usuario_crea=admin.id,
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
    usuario.usuario_modifica = admin.id
    if usuario.persona:
      usuario.persona.usuario_modifica = admin.id
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
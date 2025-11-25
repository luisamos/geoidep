import re
import hmac
import secrets
import unicodedata
from collections import OrderedDict
from copy import deepcopy
from types import SimpleNamespace

from flask import (
  Blueprint,
  current_app,
  render_template,
  request,
  abort,
  url_for,
  session,
)
from sqlalchemy.orm import joinedload
from sqlalchemy import func, or_, and_
from markupsafe import escape
from pathlib import Path
from urllib.parse import parse_qsl, urlencode, urlparse, urlunparse, quote

from apps.models import HerramientaDigital
from apps.models import Categoria
from apps.models import Institucion
from apps.models import TipoServicio
from apps.models import CapaGeografica, ServicioGeografico
from apps.extensions import cache

bp = Blueprint('geoportal', __name__)

SEARCH_TOKEN_SESSION_KEY = 'catalog_search_token'

EXCLUDED_PARENT_IDS = tuple(range(10))

DEFAULT_CAPA_PARENT_IDS = frozenset({2, 3})
DEFAULT_CAPA_TIPO_IDS = frozenset({11, 12, 14, 17, 20})

WFS_FORMATOS_ARCGIS = (
  ('GEOJSON', 'GEOJSON'),
  ('KML', 'KML'),
  ('SHAPE+ZIP', 'SHAPE+ZIP'),
  ('CSV', 'CSV'),
  ('Geopackage', 'GEOPACKAGE'),
)

WFS_FORMATOS_GEOSERVER = (
  ('GEOJSON', 'application/json'),
  ('KML', 'application/vnd.google-earth.kml+xml'),
  ('SHAPE+ZIP', 'shape-zip'),
  ('CSV', 'csv'),
  ('Geopackage', 'application/geopackage+sqlite3'),
)

def sanitize_text(value):
  if value is None:
    return None
  return str(escape(value))

def sanitize_query_text(value):
  if not value:
    return ''
  return re.sub(r"[<>\"'`]", '', value).strip()

ACCENTED_CHARS = 'áéíóúüñÁÉÍÓÚÜÑ'
UNACCENTED_CHARS = 'aeiouunaeiouun'


def _normalize_for_search(expression):
  return func.lower(func.translate(expression, ACCENTED_CHARS, UNACCENTED_CHARS))


def ilike_unaccent(column, pattern):
  return _normalize_for_search(column).ilike(_normalize_for_search(pattern))

def slugify_text(value):
  if not value:
    return ''

  normalized = unicodedata.normalize('NFKD', str(value))
  ascii_text = normalized.encode('ascii', 'ignore').decode('ascii')
  slug = re.sub(r'[^a-z0-9]+', '-', ascii_text.lower()).strip('-')
  return slug


def obtener_secciones_idep():
  secciones = [
    {
      'id': 'institucional',
      'titulo': 'Institucional',
      'descripcion': (
        'Comprende la base conceptual, los actores y las etapas que permiten '
        'gestionar la Infraestructura de Datos Espaciales del Perú.'
      ),
      'subsecciones': [
        {
          'titulo': '¿Qué es la IDEP?',
          'descripcion_corta': (
            'La IDEP articula datos, servicios y estándares geoespaciales del '
            'Estado para facilitar su búsqueda, uso y reutilización segura.'
          ),
          'descripcion_larga': (
            """
            <strong>¿Qué es la IDEP?</strong><br />
            Es el conjunto articulado de políticas, estándares, organizaciones, recursos humanos y tecnológicos destinados a
            facilitar la producción, uso y acceso a la información geográfica del Estado a fin apoyar el desarrollo socioeconómico
            y favorecer la oportuna toma de decisiones (Resolución Ministerial 325-2007-PCM).

            <br /><br />
            <strong>Estructura colaborativa</strong><br />
            La IDEP es una estructura virtual en red, mantenida por las mismas entidades públicas y privadas productoras de
            información geográfica, que brindan esta información vía internet con un mínimo de protocolos y especificaciones
            normalizadas. Asegura la cooperación entre entidades públicas y privadas con el propósito de hacer accesible la
            información geográfica de nuestro territorio.

            <br /><br />
            <strong>Acceso y beneficios</strong><br />
            La IDEP permite acceder a información geográfica oficial y actualizada de una manera eficaz y a bajo costo por
            internet. Esta iniciativa integra a todos los productores de datos geográficos del Estado y está articulada con la
            Política Nacional de Transformación Digital.
            """
          ),
          'imagen': 'imagenes/que_es_idep.png',
          'icono': 'public',
          'enlace': '#',
        },
        {
          'titulo': 'Componentes de la IDEP',
          'descripcion_corta': (
            'Marco institucional, normativa, tecnología, datos, estándares y '
            'talento que hacen posible la operación de la plataforma.'
          ),
          'descripcion_larga': (
          """
          <strong>Políticas y Acuerdos inter-institucionales</strong><br />
          Está conformado por el marco normativo - institucional de la infraestructura, los lineamientos del Plan Nacional de Datos Espaciales del Perú aprobado por el CCIDEP y los diferentes acuerdos entre productores y usuarios de información georreferenciada.
          <br /><br />
          <strong>Datos</strong><br />
          Conformado por los diferentes datos georreferenciados que son producidos y administrados por las entidades públicas que son propiedad del Estado Peruano.
          <br /><br />
          <strong>Metadatos</strong><br />
          Los metadatos son los registros que describen las características de los datos o recursos de información georreferenciada.
          <br /><br />
          Solo a través de los Metadatos es posible conocer las características de los datos georreferenciados existentes, buscarlos y seleccionar los datos que se necesitan en las diferentes bases de datos de las entidades públicas y privadas, independientemente de su ubicación geográfica y la tecnología que usan.
          <br /><br />
          <strong>Estándares</strong><br />
          Son los diferentes estándares aprobados para la producción, uso e intercambio de datos georreferenciados entre entidades públicas y privadas.
          <br /><br />
          <strong>Servicios IDE</strong><br />
          Los servicios IDE ofrecen funcionalidades de uso y acceso a datos. Estos deben estar disponibles vía Internet y ser accesibles con un simple navegador o browser.
          <br /><br />
          <strong>Usuarios</strong><br />
          Son todos los ciudadanos del País,  los funcionarios públicos, los procesos y los sistemas de información (públicos o privados), que requieran disponer de información georreferenciada en línea para resolver problemas en diferentes esferas de la sociedad.
          <br /><br />
          Estos usuarios pueden ser tomadores de decisión de diferentes niveles (públicos o privados), técnicos o ciudadanos sin conocimientos especializados en el tema.
          """
          ),
          'imagen': 'imagenes/componentes_idep.png',
          'icono': 'widgets',
          'enlace': '#',
        },
        {
          'titulo': 'Organización de la IDEP',
          'descripcion_corta': (
            'Describe la estructura de coordinación, roles y espacios de '
            'gobernanza que alinean a las entidades participantes.'
          ),
          'descripcion_larga': (
            """<strong>Entidades Productoras de Información Georreferenciada</strong><br />
            Son funciones de las entidades productoras de información georreferenciada:
            <br />
            <li>Producir la información geográfica adecuándose a estándares nacionales aprobados por las entidades rectoras en cada caso y generar sus metadatos.</li>
            <li>Remitir a la entidad rectora (cuando exista) la información producida con el objeto de integrar y centralizar la información geográfica.</li>
            <li>Implementar y registrar en el Portal de Datos Espaciales del Perú (www.geoidep.gob.pe) los servicios web de información geográfica de las capas de información cuya administración es de su competencia.</li>
            <li>Promover la implementación de sus Infraestructuras de Datos Espaciales como medio para compartir información y ser nodo activo de la IDEP.</li>
            <li>Proporcionar información en atención a los requerimientos de las entidades públicas de acuerdo a la normatividad de la materia y los estándares y procedimientos de la -Infraestructura de Datos Espaciales del Perú - IDEP.</li>
            <li>Proporcionar conjuntamente con los datos espaciales, los metadatos actualizados de dicha información conforme el Perfil Básico de Metadatos aprobado por el CCIDEP.</li>
            <br />
            <strong>Entidades Usuarias de Información Georreferenciada</strong>
            Son funciones de las entidades usuarias de información georreferenciada:
            <br />
            <li>Citar la fuente de origen de la información proporcionada cuando ésta sea utilizada como insumo para producir otra información, mejorarla y/o actualizarla.</li>
            <li>Abstenerse de distribuir la información geográfica, salvo que sirva para acompañar como base a sus mapas temáticos y solo en el marco de sus competencias y funciones.</li>"""
          ),
          'imagen': 'imagenes/organizacion_idep.jpg',
          'icono': 'group',
          'enlace': '#',
        },
        {
          'titulo': 'Proceso de implementación IDE',
          'descripcion_corta': (
            'Etapas sugeridas para planificar, ejecutar y monitorear un nodo '
            'que aporte al ecosistema nacional.'
          ),
          'descripcion_larga': (
            """<strong>Esquema General de Cómo Constituirse en un Nodo IDEP</strong><br />
            Compartir y brindar acceso estandarizado a la información geográfica es una obligación para todas las entidades de la administración pública, según lo establece la normatividad vigente (D.S. 069-2011-PCM y D.S. 133-2013-PCM).
            <br /><br />
            <strong>Recomendaciones para la implementación de un Nodo IDEP:</strong><br />
            <li>Estandarizar la información para que sea integrable con datos del mismo tipo y escala.</li>
            <li>Validar y clasificar la información.</li>
            <li>Generar los metadatos de toda la información y ofrecer un servicio de búsqueda por metadatos.</li>
            <li>Coordinar con otras entidades la publicación de la información cuando existan competencias compartidas.</li>
            <li>Defina los roles de sus dependencias respecto a la producción, centralización, validación y clasificación de la información.</li>
            """
          ),
          'imagen': 'imagenes/proceso_implementacion_ide.png',
          'icono': 'sync_alt',
          'enlace': '#',
        },
      ],
    },
    {
      'id': 'estandares',
      'titulo': 'Estándares',
      'descripcion': (
        'Lineamientos técnicos que aseguran interoperabilidad, calidad y '
        'aprovechamiento de los servicios y datos geoespaciales.'
      ),
      'subsecciones': [
        {
          'titulo': '¿Qué son los estándares geográficos?',
          'descripcion_corta': (
            'Principios y normas que permiten compartir información espacial '
            'de manera uniforme entre plataformas y organizaciones.'
          ),
          'descripcion_larga': (
            """Una Infraestructura de Datos Espaciales (IDE) está enfocada en la necesidad de intercambiar y compartir información georreferenciada, sobre todo cuando esta información está distribuida en diferentes bases de datos de entidades públicas y privadas.
          <br />
          En la práctica existe una complejidad inherente al intercambio de este tipo de información, pues debido a su componente georreferenciado, pueden tener diferentes escalas, diferentes precisiones, diferentes formatos o ser elaborados considerando diferentes métodos y criterios.
          <br />
          Esta situación puede generar que dos capas de información o dos bases de datos geográficas del mismo tema, centros poblados por ejemplo, no sean integrables pese a ser parte del mismo ámbito geográfico.
          <br />
          Los estándares son especificaciones acerca de cómo debe desarrollarse una tarea o función determinada y están basados en acuerdos entre una o más entidades o un determinado grupo de personas.
          <br />
          En un ambiente como el nuestro, donde la producción de datos geográficos se da de manera descentralizada (muchas entidades produciendo información geográfica), el uso de estándares se convierte en un factor crítico para integrar los datos que provienen de diferentes entidades productoras de información y así evitar la duplicidad de presupuestos y efuerzos en la construcción de estos datos."""
          ),
          'imagen': 'imagenes/estandares_idep.png',
          'icono': 'rubric',
          'enlace': '#',
        },
        {
          'titulo': 'Estándares para producción datos geográficos',
          'descripcion_corta': (
            'Son normas que garantizan que los datos se produzcan de forma ordenada, uniforme y compatible, facilitando su integración y uso.'
          ),
          'descripcion_larga': (
          """Los estándares de producción de datos son especificaciones técnicas contenidas en documentos que describen detalladamente las características mínimas que debe cumplir un producto geográfico con el fin de crearlo de manera estandarizada.
          <br />
          El uso de estas especificaciones o estándares de producción permite la integración de los datos geográficos cuando existen varios productores de información.
          <br />
          La definición de estándares de producción de datos se desarrolla sobre la base de las competencias institucionales y las rectoría de algunas entidades públicas respecto a la producción de datos.
          <br /><br />
          <strong>NORMAS TÉCNICAS SOBRE CARTOGRAFÍA BÁSICA</strong><br />
          <strong>El Instituto Geográfico Nacional - IGN</strong>, es el ente encargado de elaborar y actualizar la cartografía oficial del Perú, para tal efecto, planea, dirige y ejecuta las actividades relacionados con la geomática, que las entidades públicas y privadas requieren para los fines de desarrollo y la defensa nacional. Es así que dentro de sus capacidades administrativas y como ente rector tiene desarrollado las especificaciones técnicas para la generación de Mapas a diferentes escalas, las cuales deben ser consideradas al momento de generar cartografía.
          <br />
          <li>IGN. Especificaciones Técnicas para la Producción de Mapas Topográficos a escalas 1:100,000, 1:50,000, 1:25,000, 1:1,000, 1:5,000</li>
          <li>Especificaciones técnicas para levantamientos geodésicos verticales</li>
          <li>Catálogo de Objetos y Símbolos para Producción de Cartografía Básica a escala 1:1000</li>
          Para mayor información ingresar al portal IGN: <a href="https://www.gob.pe/ign" target="_blank"><strong>[Click aquí]</strong></a>
          <br />
          <strong>El Sistema Nacional Integrado de Información Catastral Predial - SNCP</strong>
          Es el ente rector encargado de regular la integración y unificación de los estándares, nomenclaturas y procesos técnicos de las diferentes entidades generadoras de catastro en el país. Basado en este principio la SNCP tiene desarrollada varias normativas, políticas y procedimientos para la implementación y el desarrollo de un Catastro, incluyendo los modelos y llenado de las fichas catastrales a usarse en esta materia.
          Para mayor información ingresar al portal SNCP: <a href="https://sncp.gob.pe/" target="_blank"><strong>[Click aquí]</strong></a>
          """
          ),
          'imagen': 'imagenes/estandares_datos.jpg',
          'icono': 'data_table',
          'enlace': '#',
        },
        {
          'titulo': 'Estándares sobre Servicios de Mapas',
          'descripcion_corta': (
            'Buenas prácticas como OGC WMS, WFS y WMTS que definen cómo '
            'exponer y consumir servicios desde distintos clientes.'
          ),
          'descripcion_larga': (
          """
          Los estándares sobre servicios de mapas son especificaciones técnicas para el intercambio de datos georreferenciados vía Web.
          <br />
          Estos estándares tienen una importancia vital en la implementación de la IDEP pues posibilitan la interoperabilidad necesaria para que los diversos sistemas de información geográfica de las entidades públicas y privadas del País intercambien datos y provean un acceso oportuno a información actualizada, confiable y oficial, provista por las mismas entidades que mantienen esta información.
          <br />
          Existen dos cuerpos principales de normalización activos con estrecha relación entre sí: la Open Geospatial Consortium (OGC), formado por entidades comerciales, universidades y representantes de gobiernos cuyo fin es la definición de estándares abiertos e interoperables dentro de los Sistemas de Información Geográfica y de la World Wide Web (WWW), y la Organización Internacional de Normalización (ISO) que creó el Comité Técnico ISO TC211, el cual es un cuerpo dependiente dedicado a la temática de información geográfica y geomática.
          <br />
          Los estándares de servicios web presentados en este apartado han sido definidos sobre la base de estos cuerpos de conocimiento y son los estándares definidos en la Directiva sobre estándares de servicios Web de información georreferenciada para el intercambio de datos entre entidades de la Administración Pública aprobada por la SEGDI. Asimismo, constituyen los estándares más usados en el mundo para la implementación de infraestructuras de datos espaciales.
          <br /><br />
          <strong>Servicios de visualización (WMS y WMTS)</strong><br /><br />
          <strong>Web Map Service o Servicio de Mapas en Web (WMS)</strong>
          El servicio Web Map Service (WMS) o Servicio de publicación de mapas es un estándar propuesto por la OGC que ofrece una sencilla interfaz HTTP, el cual permite realizar una solicitud de imágenes de mapas georreferenciados de una o más bases de datos geográficas que pueden estar distribuidas en más de un servidor.
          <br />
          Una petición WMS define la capa o capas geográficas y el área de interés para ser procesadas por el administrador del servicio, la respuesta a esta solicitud es una o más imágenes de mapas georreferenciados (devuelto como JPEG, PNG, etc) que pueden ser mostradas en un aplicativo ya sea vía web o de manera local.
          <br />
          A través de la superposición de mapas obtenidos de diferentes servidores WMS es posible la creación de una red de servicios distribuidos, cuyos clientes o usuarios podrán realizar composiciones personalizadas.
          <br />
          <a href="http://www.opengeospatial.org/standards/wms" target="_blank"><strong>[Revise el estándar desde aquí]</strong></a>
          <br /><br />
          <strong>Web Map Tile Service o Servicio de Mapas en Web por Teselas (WMTS)</strong><br />
          Un WMTS es un servicio que permite almacenar los datos recientemente leídos, por tanto agilizar la carga de los mismos en caso de que estos vuelvan a ser solicitados (caché). Este servicio usa un modelo de teselas (Tiling Model) parametrizado de tal manera que un cliente puede hacer peticiones de un conjunto discreto de valores y recibir rápidamente del servidor fragmentos de imágenes prerenderizadas (Tiles), que generalmente ya no requieren de ninguna manipulación posterior para ser mostrados en pantalla.
          <br />
          Cada una de las capas (layers) de un servidor WMTS sigue una o diversas estructuras piramidales de escalas (Tile Matrix sets o conjunto de Matrices de Teselas), en la que cada escala o nivel de la pirámide, es una rásterización y fragmentación regular de los datos geográficos a una escala o tamaño de píxel concreto. Por ello, una capa puede estar disponible en varios sistemas de coordenadas, y tener diferente ámbito en función de éstos.
          <br />
          El WMTS de OGC proporciona un enfoque complementario al WMS; a diferencia del WMS que fue concebido para poder compartir por renderizado mapas personalizados y se adoptó como una solución ideal para mostrar datos dinámicos, el WMTS renuncia a la personalización de estos mapas para obtener una mayor escalabilidad, sirviendo datos prerenderizados donde la envolvente y las escalas han sido restringidas a un conjunto discreto de teselas que siguen una geometría de malla regular. 
          <br />
          <a href="http://www.opengeospatial.org/standards/wmts" target="_blank"><strong>[Revise el estándar desde aquí]</strong></a>
          <br /><br />
          <strong>Servicios de descarga (WFS y WCS)</strong><br />
          Web Feature Service o Servicio de Objetos en Web (WFS)</strong><br />
          El servicio Web Feature Service (WFS) o Servicio de publicación de objetos es un estándar definido por la OGC que describe la especificación de codificación para datos georreferenciados basados en GML (Geography Markup Language), el cual permite recuperar y modificar (consultar, insertar, actualizar y eliminar) datos espaciales en formato vectorial. Esta codificación intenta activar el transporte y almacenamiento de información geográfica mediante un XML Schema que describe su estructura, incluyendo las propiedades de geometría y los rasgos geográficos.
          <br />
          <a href="http://www.opengeospatial.org/standards/wfs" target="_blank"><strong>[Revise el estándar desde aquí]</strong></a>
          <br /><br />
          <strong>Web Coverage Service o Servicio de Coberturas en Web (WCS)</strong><br />
          El servicio Web Coverage Service (WCS) o Servicio de Coberturas de mapas, ofrece la obtención de datos georreferenciados en un formato del tipo “cobertura” multi-dimensionales para el acceso a través de la web, de modo que sean útiles para la representación o como dato de entrada de modelos científicos.
          <br />
          Al igual que el estándar Web Map Service (WMS) y el Web Feature Service (WFS), permite al cliente seleccionar parte de la información, que posee el servidor, basándose en diferentes criterios, como por ejemplo las restricciones espaciales.
          <br />
          Este estándar nos brinda un conjunto de requisitos básicos que una aplicación WCS debe cumplir, esto también es válido al utilizar el GML como un formato de entrega de la cobertura, con el cual a diferencia del WMS, que devuelve los datos georreferenciados para ser representados como mapas estáticos (devueltos como imágenes desde un servidor) el estándar Web Coverage Service define una sintaxis rica para las solicitudes en contra de estos datos devolviéndolos con su semántica original (en lugar de las imágenes) los cuales pueden ser interpretados, extrapolados, procesados, etc.
          <br />
          <a href="http://www.opengeospatial.org/standards/wcs" target="_blank"><strong>[Revise el estándar desde aquí]</strong></a>
          <br /><br />
          <strong>Servicios de localización (CSW)</strong><br />
          El servicio Catalogue Service for the Web (CSW) o Servicio de Catalogo es un estándar definido por la OGC que especifica la interfaz, el enlace y el marco de trabajo para publicar y generar búsquedas de conjuntos de información de tipo descriptiva (metadatos) sobre los datos, servicios y objetos de información relacionados.
          <br />
          Este servicio de catálogo es uno de los tres servicios fundamentales que debe existir en una Infraestructura de Datos Espaciales: consulta, visualización y descarga.
          Los servicios de los catálogos representan las características de los recursos que pueden ser consultadas y presentadas para su evaluación por los clientes, ya sean usuarios o aplicaciones software.
          <br />
          <a href="http://www.opengeospatial.org/standards/cat" target="_blank"><strong>[Revise el estándar desde aquí]</strong></a>
          <br /><br />
          <strong>Servicios de transformación (WCTS)</strong><br />
          El Coordinate Transformation Service Estándar (WCTS) o servicio de transformación de coordenadas, proporciona una forma estándar vía web, con el cual se permite transformar coordenadas de un dato o conjunto de datos (vectoriales o raster) de un sistema de referencia a otro.
          <br />
          Las transformaciones de datos entre sistemas de referencia (CRS) son especialmente importantes cuando se integran datos de distintas fuentes de información.
          <br />
          Este estándar es obligatorio para las entidades de la Administración Pública que generan información en un elipsoide distinto al elipsoide del Sistema de Referencia Geodésico 1980 - Geodetic Reference System 1980 (GRS80) o al World Geodetic System 1984 (WGS84), que se señalan en la Resolución Jefatural Nº 079-2006-IGN-OAJ-DGC del Instituto Geográfico Nacional.
          <br />
          <a href="http://www.opengeospatial.org/standards/ct" target="_blank"><strong>[Revise el estándar desde aquí]</strong></a>
          """
          ),
          'imagen': 'imagenes/servicios_ogc.jpg',
          'icono': 'rule_settings',
          'enlace': '#',
        },
        {
          'titulo': 'Catálogo de Objetos Geográficos',
          'descripcion_corta': (
            'Un catálogo de objetos geográficos es un documento o base de datos que describe y estandariza las características, atributos y reglas de cada tipo de entidad utilizada en la información geoespacial.'
          ),
          'descripcion_larga': (
            """
            Un catálogo de objetos constituye una primera aproximación a una representación abstracta y simplificada de la realidad que contiene una estructura que organiza los tipos de objetos geográficos, sus definiciones y características (atributos, dominios, relaciones y operaciones).
            <br />
            Un catálogo de objetos geográficos es el documento donde se describe de manera completa el contenido y estructura de la información georreferenciada; permitiendo establecer un lenguaje común que permita la comprensión y por tanto en el uso e intercambio de la información.
            <br />
            Un catálogo de objetos geográficos busca:
            <li>Reglamentar la estructura interna de la información georreferenciada.</li>
            <li>Aumentar el entendimiento y uso de la información georreferenciada.</li>
            <li>Incrementar la integración e intercambio de la información georreferenciada.</li>
            <li>Establecer definiciones de los objetos que aplican para cualquier escala.</li>
            <li>Simplificar el proceso de especificación de productos cartográficos o georreferenciados.</li>
            """
          ),
          'imagen': 'imagenes/catalogo_objetos_geograficos.png',
          'icono': 'description',
          'enlace': '#',
        },
      ],
    },
    {
      'id': 'metadatos',
      'titulo': 'Metadatos',
      'descripcion': (
        'Documentación estructurada que describe datasets, servicios y '
        'recursos para facilitar su hallazgo y evaluación'
      ),
      'subsecciones': [
        {
          'titulo': '¿Qué son los Metadatos?',
          'descripcion_corta': (
            'Documentación estructurada que describe datasets, servicios y '
            'recursos para facilitar su hallazgo y evaluación.'
          ),
          'descripcion_larga': (
          """
          La definición más concreta de los metadatos es qué son “datos acerca de los datos” y sirven para suministrar información sobre los datos producidos. Los metadatos consisten en información que caracteriza datos, describen el contenido, calidad, condiciones, historia, disponibilidad y otras características de los datos.
          <br />
          Los Metadatos permiten a una persona ubicar y entender los datos, incluyen información requerida para determinar qué conjuntos de datos existen para una localización geográfica particular, la información necesaria para determinar si un conjunto de datos es apropiado para fines específicos, la información requerida para recuperar o conseguir un conjunto ya identificado de datos y la información requerida para procesarlos y utilizarlos.
          <br />
          Los Metadatos proveen un inventario estandarizado de los datos georreferenciados existentes en una organización, proveen un gran potencial para usuarios que buscan cerciorarse si un dato o conjunto de datos georreferenciados son apropiados para su necesidad o si necesitan localizar datos en bases de datos de diferentes organizaciones.
          <br />
          La generación de Metadatos no solo es aplicable a la información digital, también debe aplicarse a cualquier conjunto de datos independientemente del soporte en el cual se encuentren, ya que ello puede facilitar su localización, y así, agregarle un valor añadido a la información histórica con la que cuenta una entidad.
          <br />
          Los metadatos de información georreferenciada con que cuenta una organización o un País, constituyen elementos centrales de sus Infraestructuras de Datos Espaciales, pues solo a través de éstos es posible conocer las características de los datos georreferenciados existentes, buscarlos y seleccionar los datos que se necesitan.
          <br />
          A través de los metadatos, se pueden responder las siguientes preguntas para saber si un conjunto determinado de datos se ajusta a nuestras necesidades:
          <li>¿Dónde se originó?</li>
          <li>¿Qué pasos se siguieron para crearlo?</li>
          <li>¿Qué atributos contiene?</li>
          <li>¿Cómo están proyectados los datos?</li>
          <li>¿Qué área geográfica cubre?</li>
          <li>¿Cómo obtener la información completa?</li>
          <li>¿Cuánto cuesta?</li>
          <li>¿Con que persona se puede contactar para obtener una copia?, etc.</li>
          <br />
          <strong>Rol y función de los Metadatos</strong>
          Las funciones principales de los metadatos según los autores Gayatri y Ramachandran (2007) y Kate Beard (1996) son:
          <strong>Búsqueda:</strong> Los metadatos deben proporcionar suficiente información, bien para descubrir si existen datos de interés dentro de la colección de datos disponibles, o simplemente, para saber que existen.
          <br />
          <strong>Recuperación:</strong> Los metadatos deben proporcionar información a los usuarios para que puedan adquirir la información que sea de su interés. La analogía con una biblioteca consistiría en el procedimiento a seguir para sacar un libro.
          El componente que recupera los datos desde el metadato puede ser tan simple como proporcionar un URL que identifique la localización de un conjunto de datos digitales, o tan complejo como para cubrir cuestiones de seguridad o realizar una transacción financiera para poder acceder a la información (compra en línea).
          En este sentido, también se considera la “función recuperación” a aquella información que describe cómo localizar fuera de línea los datos, la persona de contacto, los formatos de distribución de los datos o cualquier restricción de acceso a los datos, así como la información sobre los costes.
          <br />
          <strong>Transferencia:</strong> Los metadatos deben facilitar la información necesaria para que los usuarios hagan uso de los archivos recuperados en sus máquinas. Este componente incluiría información sobre el tamaño del conjunto de datos (y sus metadatos), la estructura tanto lógica como física de los datos y metadatos.
          <strong>Evaluación:</strong> Los metadatos deben considerar información que asista a los usuarios a determinar si los datos van a ser útiles para una aplicación.
          <br />
          <strong>Archivo y conservación:</strong> Los metadatos son una pieza clave para garantizar que los recursos de información se documenten, se definan sus responsables y continúen siendo accesibles en el futuro (NISO, 2004).
          <br />
          <strong>Interoperabilidad:</strong> Los metadatos facilitan la interoperabilidad, puesto que se han definido estándares de metadatos y existen protocolos compartidos para el intercambio de esta información. Protocolos como el Z39.50 o el CSW han ayudado en búsquedas simultáneas de datos en sistemas distribuidos. 
          """
          ),
          'imagen': 'imagenes/metadatos.jpg',
          'icono': 'description',
          'enlace': '#',
        },
        {
          'titulo': '¿Qué son los Servicios de Catálogo de Metadatos?',
          'descripcion_corta': (
            'Son servicios en línea que permiten encontrar información geográfica disponible (datos, mapas, servicios) a través de sus descripciones o metadatos.'
          ),
          'descripcion_larga': (
            """Los servicios de catálogo permiten la publicación y búsqueda de Metadatos de datos, servicios y aplicaciones Web. Este servicio se realiza por medio de un protocolo estándar de comunicación que transmite peticiones entre el cliente y el servidor, el cual genera como respuesta el o los registros de metadatos del recurso de información buscado en el catálogo.
            <br />
            Es a través del catálogo de metadatos de una organización que el usuario final puede buscar y finalmente acceder a los datos que guarda esta organización.
            <br />
            Los Servicios de Catálogo constituyen uno de los tres servicios básicos de una Infraestructura de Datos Espaciales - IDE, (conjuntamente con los servicios de visualización - WMS y WMTS - y los servicios de descarga - WFS y WCS) puesto que con este servicio es posible acceder y consultar todos los recursos de informaciones disponibles en una o varias entidades públicas o privadas.
            <br />
            En la actualidad este tipo de servicio puede plantearse como una red de Catálogos interconectados, los cuales deberían estar distribuidos en diferentes entidades públicas, es decir, las búsquedas que plantee el usuario final se realizarían considerando los catálogos de varias organizaciones, así de esta manera los resultados obtenidos pueden provenir de cualquiera de estos catálogos interconectados.
            <br />
            El planteamiento para el funcionamiento de un catálogo distribuido puede darse de diferentes maneras, sin embargo se presentan dos de las formas más conocidas en el mundo de las IDE’s:
            <li>El primero mediante el proceso más conocido que es el Harvesting (Cosecha de Metadatos) que se realiza a cada una de las entidades que generan sus metadatos, de modo que el catálogo distribuido almacena en su base de datos los metadatos de todas las entidades que forman la red.</li>
            <li>Y el segundo que se plantea es por medio de conexiones CSW a los catálogos de las demás entidades, de tal manera que cuando el usuario realice una consulta, esta es transferida mediantes peticiones CSW a cada uno de los catálogos que componen la red IDE y son estos los que responden.</li>"""
          ),
          'imagen': 'imagenes/servicios_metadatos.png',
          'icono': 'menu_book',
          'enlace': '#',
        },
        {
          'titulo': 'Perfiles de metadatos',
          'descripcion_corta': (
            'Un perfil de metadatos es un conjunto de campos y reglas estandarizadas para describir datos de forma uniforme.'
          ),
          'descripcion_larga': (
          """
          La Norma Técnica Peruana  NTP ISO 19115:2011, Información Geográfica. Metadatos, define y enumera un amplio conjunto de elementos para la elaboración de los Metadatos, sin embargo, en la práctica solo se utiliza un subconjunto de ese total de elementos y muchas veces, en ese subconjunto no se encuentran todos los elementos que consideraríamos necesarios para la elaboración de nuestros Metadatos.
          <br />
          Es por ello que existe la necesidad de crear un Perfil que abarque lo que deseamos informar en nuestros metadatos, teniendo en consideración para ello, la Estructura o Núcleo Base de la Norma NTP ISO 19115.
          <br />
          La Norma ISO 19106:2004, Información Geográfica. Perfiles, establece las reglas para la elaboración de Perfiles de Metadatos. Esta norma define dos clases de conformidades a tenerse en cuenta en la elaboración de un Perfil de Metadatos:
          <br />
          <li>La conformidad Clase 1 se cumple cuando se establece un perfil como un subconjunto puro de normas ISO de información geográfica, es decir se considera el Núcleo Base de la norma y no se considera algún elemento extra adicional.</li>
          <li>La conformidad Clase 2 permite que los perfiles incluyan ampliaciones dentro del contexto permitido en la norma de base, es decir aparte de considerar el Núcleo Base, se considera elementos extras adicionales que no están considerados dentro de las normas ISO(Metadatos Extendidos)
          En el grafico siguiente se trata de explicar las dos clases de conformidades:</li>
          <br />
          Un perfil de una comunidad debe contener los componentes del núcleo de metadatos, pero no necesariamente todo el resto de componentes de metadatos. Puede contener adicionalmente extensiones de metadatos (área sombreada) que deben estar definidos siguiendo las reglas de extensión de metadatos. (Fuente: NTP ISO 19115:2011 - 1ra Edicion_R.0027-2011/CNB-INDECOPI. Publicada el 2011-07-20).
          <br />
          Para el caso Peruano, el Comité Coordinador Permanente de la Infraestructura de Datos Espaciales del Perú (CCIDEP), a través del Grupo de Trabajo GT-02: Metadatos (conformado por diversas instituciones públicas del país), en coordinación con el Comité Técnico de Normalización de Información Geográfica y Geomática del INDECOPI, elaboró y aprobó el Perfil Básico de Metadatos Espaciales, el cual constituye un instrumento de referencia obligatoria para la generación de metadatos en las entidades públicas.
          <br />
          En Latinoamerica existen 2 referencias importantes sobre perfiles de metadatos:
          <li>El NEM (Núcleo Español de Metadatos) perfil elaborado en base a la Norma ISO 19115, y que está compuesto por un conjunto mínimo de elementos de metadatos recomendados en España para describir conjuntos de Datos. Se ha generado por consenso entre productores de datos en España y se adecúa a las normas de ejecución de metadatos de INSPIRE. (NEM 1.1.2010)</li>
          <li>El LAMP (Perfil de Metadatos Geográficos para Latinoamérica) se ha desarrollado de la mano de tres organizaciones clave:  Infraestructura Global de Datos Espaciales (GSDI), Instituto Geográfico Agustín Codazzi (IGAC) y el Instituto Panamericano de Geografía e Historia (IPGH). Es un perfil de basado en la ISO 19115, en fase de aprobación (septiembre del 2011), que se compone de once secciones. Ocho de ellas se consideran secciones principales (referencia de los metadatos, identificación, calidad, representación espacial, sistema de referencia, contenido, distribución, extensión de los metadatos). Los tres restantes se consideran secciones de soporte (mención, contacto, información de la fecha). (Miguel A. Bernabé-Poveda – Fundamentos de las IDE’s).</li>
          """
          ),
          'imagen': 'imagenes/servicios_metadatos.png',
          'icono': 'book',
          'enlace': '#',
        },
        {
          'titulo': 'Perfil básico de metadatos',
          'descripcion_corta': (
            'Perfil Básico de Metadatos Espaciales del Comité Coordinador Permanente de la Infraestructura de Datos Espaciales del Perú.'
          ),
          'descripcion_larga': (
          """
          Perfil Básico de Metadatos es un estándar para la catalogación de Datos Espaciales, comprende la información mínima que debería contener el Metadato de un Dato Espacial para describirlo adecuadamente. Este estándar ha sido aprobado por el Comité Coordinador Permanente de la Infraestructura de Datos Espaciales – CCIDEP adoptando normas técnicas nacionales y estándares internacionales.
          <br /><br />
          <a href="../static/docs/ANEXO2_PERFIL_BASICO_DE_METADATOS.pdf" target="_blank"><strong>[Descargar Perfil básico de metadatos en formato PDF.]</strong></a>
          <br /><br />
          <a href="../static/docs/ANEXO1_LINEAMIENTOS_TECNICOS_PARA_LA_PRODUCCION_Y_GESTION_DE_METADATOS.pdf" target="_blank"><strong>[Lineamientos para la implementación de metadatos en entidades de la administración pública.]</strong></a>
          <br /><br />
          El Perfil Básico de Metadatos elaborado por el CCIDEP ha sido elaborado en formato XML siguiendo el estándar 19139 de la OGC:
          <br />
          <a href="../static/docs/Perfil-Basico-IDEP-2.2-19139-2018.zip" target="_blank"><strong>[Descargar el Perfil Básico de Metadatos en formato XML.]</strong></a>
          """),
          'imagen': 'imagenes/perfil_ccidep.png',
          'icono': 'download',
          'enlace': '#',
        },
        {
          'titulo': 'Manuales de instalación de Geonetwork',
          'descripcion_corta': (
            'Son guías que indican cómo instalar y configurar GeoNetwork.'
          ),
          'descripcion_larga': (
          """
          Los manuales de instalación de GeoNetwork son guías que explican de forma ordenada cómo instalar, configurar y poner en funcionamiento la plataforma GeoNetwork para gestionar metadatos geoespaciales.
          <br /><br />
          Geonetwork es un software libre y de código abierto utilizado para la catalogación de información relacionada con el espacio geográfico, permite la edición y búsqueda de metadatos e incluye un visualizador de mapas interactivo. Actualmente viene siendo usado como catálogo de metadatos por numerosas entidades que vienen implementando sus Infraestructuras de Datos Espaciales.
          <br /><br />
          <a href="../static/docs/ManualGeonetwork443.pdf" target="_blank"><strong>[Descargar manual de instalación de Geonetwork 4.4.3 para Ubuntu Server 24 y versiones en adelante]</strong></a>
          """),
          'imagen': 'imagenes/manual_metadatos.png',
          'icono': 'book_5',
          'enlace': '#',
        }
      ]
    },
    {
      'id': 'normatividad',
      'titulo': 'Normatividad',
      'descripcion': (
        'Marco legal y normativo que respalda la publicación, intercambio y '
        'uso responsable de la información geoespacial.'
      ),
      'subsecciones': [
        {
          'titulo': 'Normas vigentes',
          'descripcion_corta': (
            'Decretos, resoluciones y lineamientos que sustentan la '
            'implementación y operación de la IDEP en el sector público.'
          ),
          'descripcion_larga': (
            'Conoce las normas vigentes que respaldan la IDEP, incluyendo '
            'decretos supremos, resoluciones y lineamientos emitidos para '
            'garantizar la publicación y el intercambio responsable de '
            'información geoespacial.'
          ),
          'icono': 'gavel',
          'enlace': 'https://www.gob.pe/institucion/pcm/colecciones/3445-marco-normativo-de-la-infraestructura-de-datos-espaciales-del-peru-idep',
        },
        {
          'titulo': 'Normas Técnicas Peruanas',
          'descripcion_corta': (
            'Estándares nacionales que alinean terminología, formatos y '
            'procedimientos para asegurar la calidad de la información.'
          ),
          'descripcion_larga': (
            """Las Normas Técnicas Peruanas relacionadas con información '
            'geoespacial ayudan a unificar criterios de calidad, formatos y '
            'procesos. Revisarlas facilita que los nodos de la IDEP cumplan '
            'estándares reconocidos a nivel nacional:
            <br /><br />
            <strong>NTP ISO 19115-1:2021 – Metadatos geográficos (Parte 1)</strong><br />
            Permite describir datos y servicios geográficos de forma estandarizada. Facilita la búsqueda, evaluación y uso de información espacial mediante metadatos claros y compatibles entre instituciones.
            <br />
            <strong>NTP ISO 19111:2013 – Sistemas de referencia por coordenadas</strong><br />
            Establece cómo deben definirse los sistemas de coordenadas (como UTM o WGS84) para que los datos geográficos estén correctamente ubicados sobre la Tierra. Es clave para garantizar precisión y coherencia en mapas y análisis espaciales.
            <br />
            <strong>NTP ISO 19110:2014 (revisada el 2020) – Catalogación de objetos geográficos</strong><br />
            Define cómo organizar y describir entidades geográficas como ríos, caminos o edificaciones. Permite estructurar catálogos de objetos con atributos claros, lo que mejora la comprensión y reutilización de los datos.
            <br />
            <strong>NTP ISO 19128:2014 (revisada el 2019) – Servicios web de mapas (WMS)</strong><br />
            Establece cómo deben funcionar los servidores de mapas en internet. Gracias a esta norma, podemos visualizar mapas desde distintas fuentes en tiempo real, asegurando compatibilidad entre plataformas.
            <br /><br /><br />
            <strong>Otras Normas técnicas peruanas relevantes</strong><br />
            <strong>NTP ISO 19119 – Información Geográfica: Servicios (Interoperabilidad)</strong><br />
            Proporciona un marco para la especificación y clasificación de servicios geográficos, ampliando el modelo de referencia de arquitectura definido en ISO 19101 para abarcar servicios web de información geográfica
            Esta norma es útil para lograr la interoperabilidad entre diferentes plataformas, al definir categorías de servicios (por ejemplo, de obtención de datos, de visualización, de catálogo) y pautas para describir sus interfaces de manera independiente de la plataforma tecnológica.
            <br />
            <strong>NTP ISO 19131 – Información Geográfica: Especificaciones de producto de datos</strong><br />
            Brinda lineamientos para documentar de forma detallada las características y requisitos de un producto de datos geográficos. Esto incluye definir aspectos como el título, propósito, alcance geográfico, representación espacial, sistema de referencia, calidad esperada, formato de entrega y medios de distribución de un conjunto de datos.
            <br />
            Su utilidad radica en asegurar que los datos geográficos producidos cumplan con especificaciones estándar, facilitando su evaluación de calidad y su reutilización en diferentes proyectos.
            <br />
            <strong>NTP ISO 19157 – Información Geográfica: Calidad de datos</strong><br />
            Establece los principios y elementos para describir y evaluar la calidad de los datos geográficos.
            <br />
            Define componentes estandarizados para reportar la calidad, tales como exactitud posicional, consistencia lógica, completitud, exactitud temática, entre otros, junto con medidas e indicadores asociados. Esta norma es útil para garantizar la confiabilidad e idoneidad de los datos geoespaciales, al proporcionar un marco común para documentar la calidad y así permitir comparaciones y mejoras en los conjuntos de datos.
            <br />
            <strong>NTP ISO 19142 – Información Geográfica: Servicio Web de Objetos Geográficos (WFS)</strong><br />
            Especifica la interfaz estándar de Web Feature Service para la consulta y descarga de entidades geográficas vectoriales a través de la web.
            <br />
            Mediante WFS, diferentes sistemas pueden interoperar solicitando y obteniendo características geográficas (por ejemplo, puntos, líneas, polígonos con sus atributos) en formatos abiertos, lo que facilita el intercambio directo de datos espaciales editables entre aplicaciones GIS.
            <br />
            <strong>NTP ISO 19139 – Información Geográfica: Metadatos (Implementación en XML)</strong><br />
            Define la codificación XML de los metadatos geográficos conformes a ISO 19115.
            <br />
            En la práctica, esta norma proporciona el esquema para representar metadatos en un formato estructurado que las máquinas pueden validar e interpretar. Su utilidad es permitir el intercambio electrónico de metadatos entre sistemas de información geográfica de manera consistente, favoreciendo la interoperabilidad y la integración de catálogos de datos geoespaciales."""
          ),
          'imagen': 'imagenes/ntp.jpg',
          'icono': 'rule',
          'enlace': '',
        },
      ],
    },
  ]

  for seccion in secciones:
    for item in seccion['subsecciones']:
      if not item.get('descripcion_corta') and item.get('descripcion'):
        item['descripcion_corta'] = item['descripcion']

      if not item.get('descripcion_larga'):
        item['descripcion_larga'] = item.get('descripcion') or item.get('descripcion_corta') or ''

      if not item.get('imagen'):
        item['imagen'] = 'imagenes/image_general.png'

      tag = item.get('tag') or slugify_text(item.get('titulo'))
      item['tag'] = tag

      enlace = item.get('enlace')
      if enlace == '#' or enlace is None or enlace == '':
        item['enlace'] = url_for('geoportal.idep_por', tag=tag)

  return secciones

def ensure_search_token():
  token = session.get(SEARCH_TOKEN_SESSION_KEY)
  if not token:
    token = secrets.token_urlsafe(32)
    session[SEARCH_TOKEN_SESSION_KEY] = token
  return token

def is_search_token_valid(provided_token):
  expected_token = session.get(SEARCH_TOKEN_SESSION_KEY)
  if not provided_token or not expected_token:
    return False
  try:
    return hmac.compare_digest(provided_token, expected_token)
  except TypeError:
    return False

def sanitize_external_url(value):
  if not value:
    return None

  value = value.strip()
  parsed = urlparse(value)

  if parsed.scheme in {'http', 'https'}:
    return value

  if not parsed.scheme and value.startswith('/'):
    return value

  return None

def obtener_imagen_herramienta_url(herramienta_id):
  if not herramienta_id:
    return url_for('static', filename='imagenes/imagen_no_disponible.jpg')

  static_folder = Path(current_app.static_folder)
  candidate_paths = []
  for directory in ('imagenes/herramientas_digitales', 'imagenes'):
    for extension in ('webp', 'jpg', 'jpeg', 'png'):
      candidate_paths.append(Path(directory) / f"{herramienta_id}.{extension}")

  for relative_path in candidate_paths:
    if (static_folder / relative_path).is_file():
      return url_for('static', filename=relative_path.as_posix())

  return url_for('static', filename='imagenes/imagen_no_disponible.jpg')

def obtener_imagen_capa_url(id_capa):
  if not id_capa:
    return url_for('static', filename='imagenes/imagen_no_disponible.png')

  static_folder = Path(current_app.static_folder)
  candidate_paths = []
  for extension in ('webp', 'jpg', 'jpeg', 'png'):
    candidate_paths.append(Path('imagenes/capas_geograficas') / f"{id_capa}.{extension}")

  for relative_path in candidate_paths:
    if (static_folder / relative_path).is_file():
      return url_for('static', filename=relative_path.as_posix())

  fallback = Path('imagenes') / 'imagen_no_disponible.png'
  if (static_folder / fallback).is_file():
    return url_for('static', filename=fallback.as_posix())

  return url_for('static', filename='imagenes/imagen_no_disponible.jpg')

@cache.memoize(timeout=300)
def obtener_configuracion_servicios():
  tipos = (
    TipoServicio.query.filter(
      TipoServicio.estado.is_(True),
      TipoServicio.id_padre.in_(DEFAULT_CAPA_PARENT_IDS),
    )
    .order_by(TipoServicio.orden.asc(), TipoServicio.nombre.asc())
    .all()
  )

  tipos_por_id = {}
  capa_tipo_ids = set()

  for tipo in tipos:
    sigla = (tipo.sigla or '').strip()
    nombre = (tipo.nombre or '').strip()
    tag = (tipo.tag or '').strip()
    recurso = (tipo.recurso or '').strip() if getattr(tipo, 'recurso', None) else None

    tipos_por_id[tipo.id] = {
      'id': tipo.id,
      'sigla': sigla or None,
      'nombre': nombre or None,
      'recurso': recurso or None,
      'tag': tag or None,
      'id_padre': tipo.id_padre,
    }

    capa_tipo_ids.add(tipo.id)

  if not capa_tipo_ids:
    capa_tipo_ids = set(DEFAULT_CAPA_TIPO_IDS)

  return {
    'por_id': tipos_por_id,
    'ids_capa': frozenset(capa_tipo_ids),
  }

def build_capabilities_url(base_url, fragment):
  if not base_url:
    return None

  base_url = base_url.strip()
  if not base_url:
    return None

  fragment = (fragment or '').strip()
  if not fragment:
    return base_url

  if fragment.startswith('?') or fragment.startswith('&'):
    fragment = fragment[1:]

  if not fragment:
    return base_url

  parsed_base = urlparse(base_url)
  base_pairs = parse_qsl(parsed_base.query, keep_blank_values=True)

  def normalize_key(key):
    normalized = (key or '').strip().lower()
    if normalized == 'services':
      return 'service'
    return normalized

  merged_pairs = OrderedDict()

  for key, value in base_pairs:
    normalized_key = normalize_key(key)
    if not normalized_key:
      continue
    if normalized_key in merged_pairs:
      continue
    merged_pairs[normalized_key] = (key, value)

  fragment_pairs = parse_qsl(fragment, keep_blank_values=True)
  for key, value in fragment_pairs:
    normalized_key = normalize_key(key)
    if not normalized_key:
      continue
    if normalized_key in merged_pairs:
      continue
    merged_pairs[normalized_key] = (key, value)

  new_query = urlencode(list(merged_pairs.values()), doseq=True)
  updated = parsed_base._replace(query=new_query)
  return urlunparse(updated)

def es_servicio_wfs_arcgis(base_url):
  if not base_url:
    return False

  return 'mapserver/wfsserver' in base_url.lower()

def obtener_opciones_formato_wfs(base_url):
  if es_servicio_wfs_arcgis(base_url):
    return WFS_FORMATOS_ARCGIS
  return WFS_FORMATOS_GEOSERVER

def construir_url_descarga_wfs(base_url, nombre_capa, formato_salida):
  if not base_url or not nombre_capa or not formato_salida:
    return None

  parsed_base = urlparse(base_url)
  base_pairs = parse_qsl(parsed_base.query, keep_blank_values=True)
  base_pairs = [
    (key, value)
    for key, value in base_pairs
    if key.lower() not in {'service', 'request', 'typename', 'outputformat'}
  ]

  base_pairs.extend(
    [
      ('service', 'WFS'),
      ('request', 'GetFeature'),
      ('typeName', nombre_capa),
      ('outputFormat', formato_salida),
    ]
  )

  new_query = urlencode(base_pairs, doseq=True, quote_via=quote)
  updated = parsed_base._replace(query=new_query)
  return urlunparse(updated)

def construir_opciones_descarga_wfs(base_url, nombre_capa):
  base_url = sanitize_external_url(base_url)
  nombre_capa = (nombre_capa or '').strip()

  if not base_url or not nombre_capa:
    return []

  opciones = []
  for etiqueta, formato in obtener_opciones_formato_wfs(base_url):
    url_descarga = construir_url_descarga_wfs(base_url, nombre_capa, formato)
    if url_descarga:
      opciones.append(
        {
          'label': etiqueta,
          'url': url_descarga,
        }
      )

  return opciones

def obtener_sigla_servicio(tipo_servicio, id_servicio):
  if tipo_servicio is not None:
    sigla = getattr(tipo_servicio, 'sigla', None)
    if sigla:
      return sanitize_text(sigla)
    nombre = getattr(tipo_servicio, 'nombre', None)
    if nombre:
      return sanitize_text(nombre)

  configuracion = obtener_configuracion_servicios()
  datos_tipo = configuracion['por_id'].get(id_servicio, {})
  sigla = datos_tipo.get('sigla') or datos_tipo.get('nombre')
  return sanitize_text(sigla) if sigla else None

def obtener_recurso_tipo_servicio(tipo_servicio, id_servicio):
  if tipo_servicio is not None:
    recurso = getattr(tipo_servicio, 'recurso', None)
    if recurso:
      recurso = recurso.strip()
      if recurso:
        return recurso

  configuracion = obtener_configuracion_servicios()
  datos_tipo = configuracion['por_id'].get(id_servicio, {})
  recurso = datos_tipo.get('recurso')
  return recurso.strip() if recurso else None

def obtener_tipos_servicios_catalogo():
  tipos = (
    TipoServicio.query.filter(
      TipoServicio.id_padre.in_((1, 2, 3)),
      TipoServicio.estado.is_(True),
    )
    .order_by(TipoServicio.orden.asc(), TipoServicio.nombre.asc())
    .all()
  )

  tipos_catalogo = []
  tipos_por_slug = {}

  for tipo in tipos:
    slug_base = (tipo.tag or '').strip() or slugify_text(tipo.nombre)
    if not slug_base:
      slug_base = f"tipo-{tipo.id}"

    slug_normalizado = slug_base.lower()

    tipo_data = {
      'id': tipo.id,
      'nombre': sanitize_text(tipo.nombre),
      'descripcion': sanitize_text(tipo.descripcion),
      'logotipo': tipo.logotipo,
      'slug': slug_base,
      'tag': slug_base,
    }

    tipos_catalogo.append(tipo_data)
    if slug_normalizado and slug_normalizado not in tipos_por_slug:
      tipos_por_slug[slug_normalizado] = tipo_data

  return SimpleNamespace(lista=tipos_catalogo, por_slug=tipos_por_slug)
  return SimpleNamespace(lista=tipos_catalogo, por_slug=tipos_por_slug)

@cache.memoize(timeout=300)
def obtener_datos_catalogo_cacheados(
  id_tipo,
  id_categoria,
  id_institucion,
  filter_terms,
  estado_filter=None,
):
  id_categoria = id_categoria or None
  id_institucion = id_institucion or None
  if estado_filter not in (0, 1, None):
    estado_filter = None

  categorias = OrderedDict()
  configuracion_servicios = obtener_configuracion_servicios()
  es_tipo_capa = id_tipo in configuracion_servicios['ids_capa']

  if es_tipo_capa:
    query = (
      CapaGeografica.query.options(
        joinedload(CapaGeografica.categoria),
        joinedload(CapaGeografica.institucion),
        joinedload(CapaGeografica.servicios).joinedload(
          ServicioGeografico.tipo_servicio
        ),
      )
      .filter(
        CapaGeografica.servicios.any(
          and_(
            ServicioGeografico.id_tipo_servicio == id_tipo,
            *(
              [ServicioGeografico.estado.is_(bool(estado_filter))]
              if estado_filter is not None
              else []
            ),
          )
        )
      )
    )

    if id_institucion:
      query = query.filter(CapaGeografica.id_institucion == id_institucion)

    if id_categoria:
      query = query.filter(CapaGeografica.id_categoria == id_categoria)

    if filter_terms:
      pattern = f"%{filter_terms}%"
      query = query.filter(
        or_(
          ilike_unaccent(CapaGeografica.nombre, pattern),
          ilike_unaccent(CapaGeografica.descripcion, pattern),
          CapaGeografica.servicios.any(
            ilike_unaccent(ServicioGeografico.nombre_capa, pattern)
          ),
          CapaGeografica.servicios.any(
            ilike_unaccent(ServicioGeografico.titulo_capa, pattern)
          ),
        )
      )

    capas = query.all()
    capas.sort(
      key=lambda capa: (
        (capa.categoria.nombre.lower() if capa.categoria and capa.categoria.nombre else ''),
        (capa.nombre.lower() if capa.nombre else ''),
      )
    )

    for capa in capas:
      categoria = capa.categoria
      if not categoria:
        continue

      servicios_relacionados = []
      for servicio in capa.servicios:
        if servicio.id_tipo_servicio not in configuracion_servicios['ids_capa']:
          continue

        estado_activo = servicio.estado is True
        if estado_filter == 1 and not estado_activo:
          continue
        if estado_filter == 0 and estado_activo:
          continue

        servicios_relacionados.append(servicio)

      if not any(
        servicio.id_tipo_servicio == id_tipo
        for servicio in servicios_relacionados
      ):
        continue

      categoria_data = categorias.setdefault(
        categoria.id,
        {
          'id': categoria.id,
          'nombre': sanitize_text(categoria.nombre),
          'descripcion': sanitize_text(categoria.definicion),
          'herramientas': [],
        },
      )

      institucion = capa.institucion
      institucion_info = None
      if institucion and institucion.id_padre not in EXCLUDED_PARENT_IDS:
        institucion_info = sanitize_text(institucion.nombre)

      servicios_data = []
      acciones = []
      acciones_vistas = set()
      acciones_copia = set()
      def servicio_sort_key(item):
        tipo = item.tipo_servicio
        orden = getattr(tipo, 'orden', None)
        if orden is None:
          orden = 9999
        sigla_orden = obtener_sigla_servicio(tipo, item.id_tipo_servicio) or ''
        return (
          orden,
          sigla_orden.lower(),
        )

      for servicio in sorted(servicios_relacionados, key=servicio_sort_key):
        recurso = sanitize_external_url(servicio.direccion_web)
        estado_activo = servicio.estado is True
        sigla = obtener_sigla_servicio(
          servicio.tipo_servicio,
          servicio.id_tipo_servicio,
        )
        copy_url = None
        download_options = []
        layer_name = None
        if servicio.nombre_capa and servicio.nombre_capa.strip():
          layer_name = servicio.nombre_capa.strip()
        elif servicio.titulo_capa and servicio.titulo_capa.strip():
          layer_name = servicio.titulo_capa.strip()
        elif capa and capa.nombre:
          layer_name = capa.nombre.strip()
        recurso_tipo = obtener_recurso_tipo_servicio(
          servicio.tipo_servicio,
          servicio.id_tipo_servicio,
        )
        if recurso:
          if recurso_tipo:
            copy_url = build_capabilities_url(recurso, recurso_tipo)
          else:
            copy_url = recurso

        sigla_display = sigla or 'SERVICIO'
        view_map_url = None
        if estado_activo and sigla_display and 'WMS' in sigla_display.upper():
          view_map_url = f"https://visor.geoperu.gob.pe/?idcapa={servicio.id}"

        if (
          estado_activo
          and recurso
          and layer_name
          and sigla_display
          and 'WFS' in sigla_display.upper()
        ):
          download_options = construir_opciones_descarga_wfs(recurso, layer_name)

        if estado_activo and view_map_url and view_map_url not in acciones_vistas:
          acciones.append(
            {
              'tipo': 'view_map',
              'url': view_map_url,
            }
          )
          acciones_vistas.add(view_map_url)

        if estado_activo and copy_url:
          copy_key = (sigla_display, copy_url)
          if copy_key not in acciones_copia:
            acciones.append(
              {
                'tipo': 'copy',
                'url': copy_url,
                'sigla': sigla_display,
              }
            )
            acciones_copia.add(copy_key)

        servicios_data.append(
          {
            'estado': 1 if estado_activo else 0,
            'estado_is_active': estado_activo,
            'copy_url': copy_url if estado_activo else None,
            'view_map_url': view_map_url,
            'sigla': sigla_display,
            'id_tipo_servicio': servicio.id_tipo_servicio,
            'download_options': download_options,
          }
        )

      estado_general_activo = any(
        item['estado_is_active'] for item in servicios_data
      )

      categoria_data['herramientas'].append(
        {
          'id': capa.id,
          'nombre': sanitize_text(capa.nombre),
          'descripcion': sanitize_text(capa.descripcion),
          'institucion': institucion_info,
          'servicios': servicios_data,
          'acciones': acciones,
          'estado': 1 if estado_general_activo else 0,
          'estado_label': 'Disponible' if estado_general_activo else 'No disponible',
          'estado_is_active': estado_general_activo,
          'recurso': None,
          'imagen_url': obtener_imagen_capa_url(capa.id),
          'tipo_servicio': None,
          'es_capa': True,
        }
      )

    instituciones_disponibles = (
      Institucion.query.join(Institucion.capas)
      .join(CapaGeografica.servicios)
      .filter(
        ServicioGeografico.id_tipo_servicio == id_tipo,
        ~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS),
      )
    )

    if id_categoria:
      instituciones_disponibles = instituciones_disponibles.filter(
        CapaGeografica.id_categoria == id_categoria
      )

    if estado_filter is not None:
      instituciones_disponibles = instituciones_disponibles.filter(
        ServicioGeografico.estado.is_(bool(estado_filter))
      )

    instituciones_disponibles = (
      instituciones_disponibles.with_entities(
        Institucion.id,
        Institucion.nombre,
        Institucion.sigla,
      )
      .order_by(Institucion.id.asc())
      .distinct()
      .all()
    )

    categorias_disponibles_query = (
      Categoria.query.join(Categoria.capas)
      .join(CapaGeografica.servicios)
      .filter(ServicioGeografico.id_tipo_servicio == id_tipo)
    )

    if estado_filter is not None:
      categorias_disponibles_query = categorias_disponibles_query.filter(
        ServicioGeografico.estado.is_(bool(estado_filter))
      )

    categorias_disponibles = (
      categorias_disponibles_query.with_entities(Categoria.id, Categoria.nombre)
      .order_by(Categoria.nombre.asc())
      .distinct()
      .all()
    )
  else:
    query = (
      HerramientaDigital.query.options(
        joinedload(HerramientaDigital.categoria),
        joinedload(HerramientaDigital.institucion),
        joinedload(HerramientaDigital.tipo_servicio),
      )
      .filter(HerramientaDigital.id_tipo_servicio == id_tipo)
      .join(HerramientaDigital.categoria)
    )

    if id_categoria:
      query = query.filter(HerramientaDigital.id_categoria == id_categoria)

    if id_institucion:
      query = query.filter(HerramientaDigital.id_institucion == id_institucion)

    if estado_filter is not None:
      query = query.filter(HerramientaDigital.estado == bool(estado_filter))

    if filter_terms:
      pattern = f"%{filter_terms}%"
      query = query.filter(
        or_(
          ilike_unaccent(HerramientaDigital.nombre, pattern),
          ilike_unaccent(HerramientaDigital.descripcion, pattern),
        )
      )

    herramientas = query.order_by(
      func.lower(Categoria.nombre), func.lower(HerramientaDigital.nombre)
    ).all()

    for herramienta in herramientas:
      categoria = herramienta.categoria
      if not categoria:
        continue

      categoria_data = categorias.setdefault(
        categoria.id,
        {
          'id': categoria.id,
          'nombre': sanitize_text(categoria.nombre),
          'descripcion': sanitize_text(categoria.definicion),
          'herramientas': [],
        },
      )

      institucion = herramienta.institucion
      institucion_nombre = None
      if institucion and institucion.id_padre not in EXCLUDED_PARENT_IDS:
        institucion_nombre = sanitize_text(institucion.nombre)

      estado = herramienta.estado or 0
      estado_is_active = estado == 1
      estado_label = 'Disponible' if estado_is_active else 'En mantenimiento'
      recurso = sanitize_external_url(herramienta.recurso)

      categoria_data['herramientas'].append(
        {
          'id': herramienta.id,
          'nombre': sanitize_text(herramienta.nombre),
          'descripcion': sanitize_text(herramienta.descripcion),
          'institucion': institucion_nombre,
          'recurso': recurso,
          'estado': estado,
          'estado_label': estado_label,
          'estado_is_active': estado_is_active,
          'imagen_url': obtener_imagen_herramienta_url(herramienta.id),
          'tipo_servicio': sanitize_text(
            herramienta.tipo_servicio.nombre if herramienta.tipo_servicio else None
          ),
          'servicios': [],
          'acciones': [],
          'es_capa': False,
        }
      )

    instituciones_disponibles = (
      Institucion.query.join(Institucion.herramientas)
      .filter(
        HerramientaDigital.id_tipo_servicio == id_tipo,
        ~Institucion.id_padre.in_(EXCLUDED_PARENT_IDS),
      )
    )

    if id_categoria:
      instituciones_disponibles = instituciones_disponibles.filter(
        HerramientaDigital.id_categoria == id_categoria
      )

    if estado_filter is not None:
      instituciones_disponibles = instituciones_disponibles.filter(
        HerramientaDigital.estado == bool(estado_filter)
      )

    instituciones_disponibles = (
      instituciones_disponibles.with_entities(
        Institucion.id,
        Institucion.nombre,
        Institucion.sigla,
      )
      .order_by(Institucion.nombre.asc())
      .distinct()
      .all()
    )

    categorias_disponibles_query = (
      Categoria.query.join(Categoria.herramientas)
      .filter(HerramientaDigital.id_tipo_servicio == id_tipo)
    )

    if estado_filter is not None:
      categorias_disponibles_query = categorias_disponibles_query.filter(
        HerramientaDigital.estado == bool(estado_filter)
      )

    categorias_disponibles = (
      categorias_disponibles_query.with_entities(Categoria.id, Categoria.nombre)
      .order_by(Categoria.nombre.asc())
      .distinct()
      .all()
    )

  categorias_list = list(categorias.values())
  total_herramientas = sum(
    len(categoria_data['herramientas']) for categoria_data in categorias_list
  )

  categorias_opciones = [
    {'id': id_cat, 'nombre': sanitize_text(nombre)}
    for id_cat, nombre in categorias_disponibles
  ]

  instituciones_opciones = [
    {
      'id': id_inst,
      'nombre': sanitize_text(nombre),
      'sigla': sanitize_text(sigla) if sigla else None,
    }
    for id_inst, nombre, sigla in instituciones_disponibles
  ]

  categorias_opciones.sort(key=lambda item: (item['nombre'] or '').lower())
  instituciones_opciones.sort(key=lambda item: (item['nombre'] or '').lower())

  return {
    'categorias': categorias_list,
    'categorias_opciones': categorias_opciones,
    'instituciones_opciones': instituciones_opciones,
    'total_herramientas': total_herramientas,
  }


def construir_contexto_catalogo(tipos_catalogo, tipo_config=None):
  id_institucion = request.args.get('id_institucion', type=int)
  id_categoria = request.args.get('id_categoria', type=int)
  estado_param = request.args.get('ordenar', type=str)
  provided_token = request.args.get('search_token', type=str)
  filter_terms_raw = request.args.get('filter_terms', default='', type=str)
  search_token = ensure_search_token()

  estado_filter = None
  if estado_param in {'0', '1'}:
    estado_filter = int(estado_param)
  else:
    estado_param = ''

  filter_terms = ''
  if filter_terms_raw:
    if is_search_token_valid(provided_token):
      filter_terms = sanitize_query_text(filter_terms_raw)
      if filter_terms_raw and not filter_terms:
        filter_terms = ''
    else:
      filter_terms_raw = ''

  categorias_opciones = []
  instituciones_opciones = []
  categorias_list = []
  total_herramientas = 0
  selected_tipo = None
  selected_tipo_slug = None
  applied_filters = []

  estado_cache_key = estado_filter if estado_filter is not None else -1

  if tipo_config:
    selected_tipo = {
      'id': tipo_config['id'],
      'nombre': tipo_config['nombre'],
      'descripcion': tipo_config.get('descripcion'),
      'slug': tipo_config.get('slug') or tipo_config.get('tag'),
    }

    id_tipo = tipo_config['id']
    selected_tipo_slug = (tipo_config.get('slug') or tipo_config.get('tag') or '').lower()

    cache_args = (
      id_tipo,
      id_categoria or 0,
      id_institucion or 0,
      filter_terms.lower() if filter_terms else '',
      estado_cache_key,
    )
    datos_cacheados = deepcopy(obtener_datos_catalogo_cacheados(*cache_args))

    categorias_list = datos_cacheados['categorias']
    categorias_opciones = datos_cacheados['categorias_opciones']
    instituciones_opciones = datos_cacheados['instituciones_opciones']
    total_herramientas = datos_cacheados['total_herramientas']

    if selected_tipo['nombre']:
      applied_filters.append(
        {
          'label': selected_tipo['nombre'],
          'type': 'tipo',
        }
      )
      for categoria in categorias_list:
        for herramienta in categoria.get('herramientas', []):
          if not herramienta.get('tipo_servicio'):
            herramienta['tipo_servicio'] = selected_tipo['nombre']
  else:
    aggregated_request = any(
      [
        filter_terms,
        id_categoria,
        id_institucion,
        estado_filter is not None,
      ]
    )

    if aggregated_request:
      categorias_agregadas = OrderedDict()
      categorias_opciones_map = {}
      instituciones_opciones_map = {}

      for tipo in tipos_catalogo.lista:
        id_tipo = tipo.get('id')
        if not id_tipo:
          continue

        cache_args = (
          id_tipo,
          id_categoria or 0,
          id_institucion or 0,
          filter_terms.lower() if filter_terms else '',
          estado_cache_key,
        )
        datos_tipo = deepcopy(obtener_datos_catalogo_cacheados(*cache_args))

        if not datos_tipo['total_herramientas']:
          continue

        for categoria in datos_tipo['categorias']:
          categoria_acumulada = categorias_agregadas.setdefault(
            categoria['id'],
            {
              'id': categoria['id'],
              'nombre': categoria.get('nombre'),
              'descripcion': categoria.get('descripcion'),
              'herramientas': [],
            },
          )

          for herramienta in categoria.get('herramientas', []):
            if not herramienta.get('tipo_servicio'):
              herramienta['tipo_servicio'] = tipo.get('nombre')
            categoria_acumulada['herramientas'].append(herramienta)

        for opcion in datos_tipo['categorias_opciones']:
          categorias_opciones_map[opcion['id']] = opcion

        for opcion in datos_tipo['instituciones_opciones']:
          existente = instituciones_opciones_map.get(opcion['id'])
          if not existente or (opcion.get('sigla') and not existente.get('sigla')):
            instituciones_opciones_map[opcion['id']] = opcion

      categorias_list = [
        datos
        for _, datos in sorted(
          categorias_agregadas.items(),
          key=lambda item: (item[1]['nombre'] or '').lower(),
        )
      ]

      for categoria in categorias_list:
        categoria['herramientas'].sort(
          key=lambda item: (item.get('nombre') or '').lower()
        )

      categorias_opciones = sorted(
        categorias_opciones_map.values(),
        key=lambda item: (item['nombre'] or '').lower(),
      )
      instituciones_opciones = sorted(
        instituciones_opciones_map.values(),
        key=lambda item: (item['nombre'] or '').lower(),
      )

      total_herramientas = sum(
        len(categoria.get('herramientas', [])) for categoria in categorias_list
      )

  if id_categoria:
    selected_categoria_nombre = next(
      (cat['nombre'] for cat in categorias_opciones if cat['id'] == id_categoria),
      None,
    )
    if selected_categoria_nombre:
      applied_filters.append(
        {
          'label': selected_categoria_nombre,
          'type': 'categoria',
        }
      )

  if id_institucion:
    selected_institucion = next(
      (inst for inst in instituciones_opciones if inst['id'] == id_institucion),
      None,
    )
    if selected_institucion:
      label = selected_institucion['nombre']
      if selected_institucion.get('sigla'):
        label = f"{label} ({selected_institucion['sigla']})"
      applied_filters.append(
        {
          'label': label,
          'type': 'entidad',
        }
      )

  if filter_terms:
    applied_filters.append(
      {
        'label': f"Contiene: {sanitize_text(filter_terms)}",
        'type': 'search',
      }
    )

  if estado_filter is not None:
    applied_filters.append(
      {
        'label': 'Disponible' if estado_filter == 1 else 'En mantenimiento',
        'type': 'estado',
      }
    )

  clear_filters_enabled = bool(applied_filters)

  return {
    'tipos_servicios': tipos_catalogo.lista,
    'selected_tipo': selected_tipo,
    'selected_tipo_slug': selected_tipo_slug,
    'categorias': categorias_list,
    'categorias_opciones': categorias_opciones,
    'instituciones_opciones': instituciones_opciones,
    'selected_id_categoria': id_categoria,
    'selected_id_institucion': id_institucion,
    'filter_terms': filter_terms,
    'selected_estado': estado_filter,
    'applied_filters': applied_filters,
    'clear_filters_enabled': clear_filters_enabled,
    'total_herramientas': total_herramientas,
    'catalogo_url': url_for('geoportal.catalogo'),
    'search_token': search_token,
  }

@bp.route('/')
def principal():
  tipos_catalogo = obtener_tipos_servicios_catalogo()
  geoportales_count = HerramientaDigital.query.filter(
      HerramientaDigital.id_tipo_servicio == 5
  ).count()
  servicios_mapas_count = CapaGeografica.query.count()
  visores_count = HerramientaDigital.query.filter(
      HerramientaDigital.id_tipo_servicio == 6
  ).count()
  catalogo_metadatos_count = HerramientaDigital.query.filter(
      HerramientaDigital.id_tipo_servicio == 9
  ).count()

  estadisticas = [
    {
      'label': 'Geoportales institucionales',
      'count': geoportales_count,
    },
    {
      'label': 'Servicios de mapas geográficos',
      'count': servicios_mapas_count,
    },
    {
      'label': 'Visores de mapas institucional',
      'count': visores_count,
    },
    {
      'label': 'Catálogo de Metadatos geográficos',
      'count': catalogo_metadatos_count,
    },
  ]

  for estadistica in estadisticas:
    estadistica['display_value'] = f"+{estadistica['count']:,}".replace(',', '')

  return render_template(
      'geoportal/inicio.html',
      tipos_servicios=tipos_catalogo.lista,
      estadisticas=estadisticas,
      catalogo_url=url_for('geoportal.catalogo'),
      search_token=ensure_search_token(),
  )

@bp.route('/catalogo')
def catalogo():
  tipos_catalogo = obtener_tipos_servicios_catalogo()
  contexto = construir_contexto_catalogo(tipos_catalogo)
  return render_template('geoportal/catalogo.html', **contexto)

@bp.route('/catalogo/<slug>')
def catalogo_por_tipo(slug):
  slug_normalizado = slug.lower()
  tipos_catalogo = obtener_tipos_servicios_catalogo()
  tipo_config = tipos_catalogo.por_slug.get(slug_normalizado)
  if not tipo_config:
    abort(404)
  contexto = construir_contexto_catalogo(tipos_catalogo, tipo_config)
  return render_template('geoportal/catalogo.html', **contexto)

@bp.route('/idep')
def idep():
  secciones = obtener_secciones_idep()
  return render_template('geoportal/idep.html', secciones=secciones)

@bp.route('/idep/<tag>')
def idep_por(tag):
  secciones = obtener_secciones_idep()
  tag_normalizado = slugify_text(tag)
  detalle = None
  seccion_origen = None

  for seccion in secciones:
    for item in seccion['subsecciones']:
      if slugify_text(item.get('tag')) == tag_normalizado:
        detalle = item
        seccion_origen = seccion
        break
    if detalle:
      break

  if not detalle:
    abort(404)

  return render_template(
      'geoportal/descripcion.html',
      titulo=detalle.get('titulo'),
      descripcion_larga=detalle.get('descripcion_larga'),
      imagen=url_for('static', filename=detalle.get('imagen')),
      seccion=seccion_origen,
  )
from flask import request, jsonify, Blueprint, make_response
import requests

from app.config import API_KEY_GEOAPIFY

bp = Blueprint('geoapify', __name__, url_prefix='/geoapify')


@bp.after_request
def add_cors_headers(response):
  response.headers["Access-Control-Allow-Origin"] = "https://visor.geoperu.gob.pe"
  response.headers["Access-Control-Allow-Methods"] = "GET, OPTIONS"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type, Authorization"
  return response


@bp.route("", methods=["GET", "OPTIONS"])
@bp.route("/", methods=["GET", "OPTIONS"])
def geoapify_autocomplete():
  if request.method == "OPTIONS":
    return make_response("", 204)

  q = request.args.get("q", "").strip()

  if not q:
    return jsonify({
      "error": "Missing query parameter q"
    }), 400

  url = "https://api.geoapify.com/v1/geocode/autocomplete"

  params = {
    "text": q,
    "filter": "countrycode:pe",
    "lang": "es",
    "limit": 5,
    "apiKey": API_KEY_GEOAPIFY
  }

  try:
    response = requests.get(url, params=params, timeout=10)
    response.raise_for_status()

    return jsonify(response.json())

  except requests.exceptions.Timeout:
    return jsonify({
      "error": "Geoapify request timeout"
    }), 504

  except requests.exceptions.RequestException as e:
    return jsonify({
      "error": "Error requesting Geoapify service",
      "details": str(e)
    }), 500
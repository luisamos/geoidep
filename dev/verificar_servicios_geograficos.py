import argparse
import asyncio
import logging
import sys
from pathlib import Path

root_dir = Path(__file__).resolve().parents[1]
if str(root_dir) not in sys.path:
    sys.path.insert(0, str(root_dir))

from app import create_app, db
from app.services.monitoreo import RequestConfig, ejecutar_monitoreo


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Verifica herramientas y servicios geográficos, actualiza su estado y registra logs.",
    )
    parser.add_argument(
        "--tipo",
        type=str,
        default="todos",
        choices=["todos", "servicios_geograficos", "herramientas_geograficas"],
        help="Tipo de recursos a verificar (default: todos).",
    )
    parser.add_argument(
        "--ids",
        type=str,
        help="Lista de IDs separados por coma para revisar en lugar de todos los registros.",
    )
    parser.add_argument("--limite", type=int, help="Número máximo de registros a revisar.")
    parser.add_argument("--timeout", type=float, default=30.0, help="Tiempo de espera HTTP.")
    parser.add_argument(
        "--delay",
        type=float,
        default=0.5,
        help="Espera en segundos entre cada petición.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Ejecuta la verificación sin guardar cambios en la base de datos.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    log_dir = Path(__file__).resolve().parent / "tmp" / "logs"
    log_dir.mkdir(parents=True, exist_ok=True)
    log_file = log_dir / "verificacion_servicios_geograficos.log"
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(log_file, encoding="utf-8"),
        ],
    )

    config = RequestConfig(
        timeout=args.timeout,
        delay=args.delay,
    )
    ids = None
    if args.ids:
        ids = [int(value) for value in args.ids.split(",") if value.strip().isdigit()]

    app = create_app()
    with app.app_context():
        resultado = asyncio.run(
            ejecutar_monitoreo(
                config=config,
                tipo=args.tipo,
                limite=args.limite,
                ids=ids,
                dry_run=args.dry_run,
            )
        )

    logging.info(
        "Resultado: SG verificados=%d (activos=%d, inactivos=%d) | "
        "HD verificadas=%d (activas=%d, inactivas=%d) | Errores=%d",
        resultado.servicios_verificados,
        resultado.servicios_activos,
        resultado.servicios_inactivos,
        resultado.herramientas_verificadas,
        resultado.herramientas_activas,
        resultado.herramientas_inactivas,
        len(resultado.errores),
    )


if __name__ == "__main__":
    main()

# Despliegue: geoidep

Pasos para desplegar o actualizar la aplicación **geoidep** en producción.

---

## Requisitos previos

- Servidor Ubuntu/Debian con nginx instalado
- Python 3.x disponible en el sistema
- Usuario `www-data` con acceso al directorio `/opt/geoidep`
- Certificados SSL en `/etc/ssl/geoidep/`

---

## Estructura en producción

```
/opt/geoidep/
├── .venv/          ← entorno virtual Python
├── .env            ← variables de entorno (no commitear)
└── app/            ← código fuente
```

Socket Unix: `/run/geoidep/geoidep.sock`

---

## 1. Clonar / actualizar el código

```bash
# Primera vez
git clone <repo-url> /opt/geoidep

# Actualizaciones posteriores
cd /opt/geoidep
git pull origin main
```

---

## 2. Crear el entorno virtual e instalar dependencias

```bash
python3 -m venv /opt/geoidep/.venv
/opt/geoidep/.venv/bin/pip install -r /opt/geoidep/requirements.txt
```

---

## 3. Crear el archivo `.env`

```bash
nano /opt/geoidep/.env
```

Contenido mínimo:

```env
SECRET_KEY=<clave-secreta>
DB_USER=<usuario-bd>
DB_PASS=<contraseña-bd>
DB_HOST=localhost
DB_PORT=5432
DB_NAME=<nombre-bd>
```

---

## 4. Ajustar permisos

```bash
chown -R www-data:www-data /opt/geoidep
chmod 750 /opt/geoidep
```

---

## 5. Crear el servicio systemd

Archivo: `/etc/systemd/system/geoidep.service`

```ini
[Unit]
Description=Geoportal de la Infraestructura de Datos Espaciales del Perú.
After=network.target

[Service]
User=www-data
Group=www-data
WorkingDirectory=/opt/geoidep
Environment=PATH=/opt/geoidep/.venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
UMask=007
RuntimeDirectory=geoidep
RuntimeDirectoryMode=0755

ExecStart=/opt/geoidep/.venv/bin/gunicorn \
    --workers 3 \
    --bind unix:/run/geoidep/geoidep.sock \
    --log-level info \
    --no-control-socket \
    "app:create_app()"

Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
```

---

## 6. Habilitar e iniciar el servicio

```bash
systemctl daemon-reload
systemctl enable geoidep.service
systemctl start geoidep.service
systemctl status geoidep.service

sudo journalctl -u geoidep -n 50 --no-pager
```

---

## 7. Configurar nginx

Archivo del sitio: `/etc/nginx/sites-available/geoidep` (o el nombre que uses).

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name _;

    listen 443 ssl;
    listen [::]:443 ssl;

    ssl_certificate /etc/ssl/geoidep/fullchain.pem;
    ssl_certificate_key /etc/ssl/geoidep/geoidep.key;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;

    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
    add_header X-Content-Type-Options nosniff;
    add_header X-Frame-Options SAMEORIGIN;
    add_header X-XSS-Protection "1; mode=block";

    server_tokens off;
    client_max_body_size 25M;
    large_client_header_buffers 4 16k;

    location / {
        include proxy_params;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://unix:/run/geoidep/geoidep.sock;
        proxy_read_timeout 120;
        proxy_connect_timeout 60;
        proxy_send_timeout 120;
        proxy_redirect http:// https://;
    }
}
```

Activar el sitio y recargar nginx:

```bash
ln -s /etc/nginx/sites-available/geoidep /etc/nginx/sites-enabled/
nginx -t
systemctl reload nginx
```

---

## 8. Verificación

```bash
systemctl status geoidep.service
ls -la /run/geoidep/geoidep.sock
journalctl -u geoidep -f
```

---

## Actualización de código (sin bajar el servicio)

```bash
cd /opt/geoidep
git pull origin main
/opt/geoidep/.venv/bin/pip install -r requirements.txt   # solo si cambiaron deps
systemctl restart geoidep.service
systemctl status geoidep.service
```

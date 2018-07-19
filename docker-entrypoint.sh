#!/bin/sh
set -e

cd /app

case "$1" in
    run)
        ${DJANGO_PYTHON} manage.py migrate --no-input
        ${DJANGO_PYTHON} manage.py instance_setup
        exec /usr/bin/gunicorn readthedocs.wsgi:application \
            --bind ${DJANGO_RUNTIME_LISTEN_IP}:${DJANGO_RUNTIME_LISTEN_PORT} \
            --workers ${DJANGO_RUNTIME_COUNT_WORKERS}
        ;;
    *)
        exec "$@"
esac

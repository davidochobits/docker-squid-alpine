#!/bin/sh
set -eu

# Asegura que los directorios de trabajo existen y pertenecen a squid
# (necesario cuando se montan volúmenes vacíos desde el host)
mkdir -p /var/cache/squid /var/log/squid
chown -R squid:squid /var/cache/squid /var/log/squid

# Inicializa los directorios de caché solo la primera vez.
# Con -N se ejecuta en primer plano: cuando termina, la caché está lista
if [ ! -d /var/cache/squid/00 ]; then
    echo "Inicializando la caché de Squid..."
    squid -z -N
fi

echo "Arrancando Squid..."

# En Kubernetes/containerd los pipes de stdout/stderr pertenecen a root;
# Squid baja privilegios al usuario squid y necesita poder escribir en ellos
chown squid:squid /dev/stdout /dev/stderr 2>/dev/null || true

# -N: primer plano (requisito para ser PID 1 en el contenedor)
# -Y: respuestas rápidas UDP_HIT_OBJ mientras recarga
# -C: no capturar señales fatales (deja que Docker las gestione)
# -d 1: logs de depuración nivel 1 a stderr (visibles con `docker logs`)
exec squid -NYCd 1 "$@"

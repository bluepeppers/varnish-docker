#!/bin/bash
set -e

LINK_VAR=$(env | grep "_TCP=" | head -1)
if [ -z $LINK_VAR ]; then
    echo "No tcp linked container"
    exit 1
fi

VARNISH_BACKEND_PORT=$(echo $LINK_VAR | sed 's/.*=tcp:\/\/\(.*\):\(.*\)/\2/')
VARNISH_BACKEND_IP=$(echo $LINK_VAR | sed 's/.*=tcp:\/\/\(.*\):\(.*\)/\1/')
echo "BACKEND IP: ${VARNISH_BACKEND_IP}"
echo "BACKEND PORT: ${VARNISH_BACKEND_PORT}"

cat <<EOF >/etc/varnish/default.vcl
backend default {
    .host = "${VARNISH_BACKEND_IP}";
    .port = "${VARNISH_BACKEND_PORT}";
}
EOF

# Start varnish and log
varnishd -f /etc/varnish/default.vcl -s malloc,100M -a 0.0.0.0:80
varnishlog

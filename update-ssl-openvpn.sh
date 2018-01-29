#!/bin/bash

source docker.env

echo "Updating Certificate"
# Update SSL Cert from Let's Encrypt
 docker run \
  -v $OPENVPN_SSL_CERTS_HOST:/etc/letsencrypt \
  -e domains=$OPENVPN_SSL_DOMAIN \
  -e email=$OPENVPN_SSL_EMAIL \
  -p 80:80 \
  -p 443:443 \
  --rm pierreprinetti/certbot:latest

# Install SSL cert for OPENVPN
echo "Installing Certificates"
docker exec $OPENVPN_NAME /config/scripts/confdba -mk cs.ca_bundle -v "`sudo cat ${OPENVPN_SSL_CERTS_HOST}/live/${OPENVPN_SSL_DOMAIN}/fullchain.pem`" > /dev/null
docker exec $OPENVPN_NAME /config/scripts/confdba -mk cs.priv_key -v "`sudo cat ${OPENVPN_SSL_CERTS_HOST}/live/${OPENVPN_SSL_DOMAIN}/privkey.pem`" > /dev/null
docker exec $OPENVPN_NAME /config/scripts/confdba -mk cs.cert -v "`sudo cat ${OPENVPN_SSL_CERTS_HOST}/live/${OPENVPN_SSL_DOMAIN}/cert.pem`" > /dev/null

echo "Restarting OpenVPN Server"
docker restart $OPENVPN_NAME

echo "Done."

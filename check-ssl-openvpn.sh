#!/bin/bash

source docker.env

openssl x509 -startdate -noout -in $OPENVPN_SSL_CERTS_HOST/live/$OPENVPN_SSL_DOMAIN/fullchain.pem
openssl x509 -enddate -noout -in $OPENVPN_SSL_CERTS_HOST/live/$OPENVPN_SSL_DOMAIN/fullchain.pem

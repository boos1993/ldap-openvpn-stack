#!/bin/bash -e
source docker.env

docker run \
	--name $LDAP_HOSTNAME \
	--hostname $LDAP_HOSTNAME \
	--detach \
	--env LDAP_DOMAIN=$LDAP_DOMAIN \
	--env LDAP_ADMIN_PASSWORD=$LDAP_CONNECT_PASS \
	-v $LDAP_DATABASE:/var/lib/ldap \
	-v $LDAP_CONFIG:/etc/ldap/slapd.d \
	osixia/openldap:1.1.8

docker run --name phpldapadmin \
		--hostname $PHPLDAP_HOSTNAME \
		--link $LDAP_HOSTNAME \
		--env PHPLDAPADMIN_HTTPS=false \
		--env PHPLDAPADMIN_LDAP_HOSTS="#PYTHON2BASH:[{'${LDAP_HOSTNAME}': [{'server': [{'tls': False}]},{'login': [{'bind_id': '${LDAP_CONNECT}'}]}]}]" \
		--detach osixia/phpldapadmin:0.7.1

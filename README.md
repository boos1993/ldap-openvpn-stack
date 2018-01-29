# LDAP OpenVPN Stack
This is a compilation of scripts that makes it easy to deploy a openldap server with phpldapadmin and have it be the authentication backend for an OpenVPN server.

# Change default admin password
docker exec -it openvpn passwd admin

# Set ssl certs to auto renew every month
crontab -l | { cat; echo "MAILTO=aboos"; } | crontab -
crontab -l | { cat; echo "0 1 1 * * /home/admin/ldap-openvpn-stack/update-ssl-openvpn.sh"; } | crontab -


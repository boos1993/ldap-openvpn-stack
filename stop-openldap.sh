#!/bin/bash

docker stop phpldapadmin
docker stop openldap

docker rm phpldapadmin
docker rm openldap

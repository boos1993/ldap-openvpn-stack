#!/bin/bash

source docker.env

docker stop $OPENVPN_NAME
docker rm $OPENVPN_NAME
sudo docker run \
	-d \
	--name=$OPENVPN_NAME \
	--restart=always \
	-v $OPENVPN_CONFIG:/config \
	-e INTERFACE=eth0 \
	-e PGID=$OPENVPN_GID \
	-e PUID=$OPENVPN_UID \
	-e TZ=$OPENVPN_TZ \
	--net=host \
	--privileged \
	linuxserver/openvpn-as

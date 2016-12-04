#!/bin/bash

IMAGE=${1:-'diginc/pi-hole:arm'}
NIC=${2:-'eth0'}
IP=$(ip addr show "$NIC" | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

# Default ports + daemonized docker container
docker run -p 53:53/tcp -p 53:53/udp -p 80:80 \
  --cap-add=NET_ADMIN \
  -e ServerIP="$IP" \
  -v $(pwd)/data/var/log/pihole.log:/var/log/pihole.log \
  -v $(pwd)/data/etc/pihole/:/etc/pihole/ \
  --restart=always \
  --name pihole \
  -d "$IMAGE"

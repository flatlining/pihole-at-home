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
  -v $(pwd)/list/adlists.list:/etc/pihole/adlists.list \
  -v $(pwd)/list/whitelist.txt:/etc/pihole/whitelist.txt \
  -v $(pwd)/list/blacklist.txt:/etc/pihole/blacklist.txt \
  --restart=always \
  --name pihole \
  -d "$IMAGE"

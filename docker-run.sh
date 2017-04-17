#!/bin/bash

IMAGE=${1:-'diginc/pi-hole:arm'}
NIC=${2:-'eth0'}
IP=$(ip addr show "$NIC" | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

dir=$HOME/docker-data
if [ ! -e $dir ]; then
    echo "Creating $dir"
    mkdir $dir
else
    echo "$dir already exist"
fi

dir=$HOME/docker-data/pihole
if [ ! -e $dir ]; then
    echo "Creating $dir"
    mkdir $dir
else
    echo "$dir already exist"
fi

dir=$HOME/docker-data/pihole/var
if [ ! -e $dir ]; then
    echo "Creating $dir"
    mkdir $dir
else
    echo "$dir already exist"
fi

dir=$HOME/docker-data/pihole/var/log
if [ ! -e $dir ]; then
    echo "Creating $dir"
    mkdir $dir
else
    echo "$dir already exist"
fi

if [ ! -f $dir/pihole.log ]; then
    echo "Creating $dir/pihole.log"
    touch $dir/pihole.log
else
    echo "$dir/pihole.log already exist"
fi

# Default ports + daemonized docker container
echo "Executing: docker run -p 53:53/tcp -p 53:53/udp -p 80:80 --cap-add=NET_ADMIN -e ServerIP=\"$IP\" -v $HOME/docker-data/pihole/var/log/pihole.log:/var/log/pihole.log -v $HOME/docker-data/pihole/etc/pihole/:/etc/pihole/ --restart=always --name pihole -d \"$IMAGE\""
docker run -p 53:53/tcp -p 53:53/udp -p 80:80 \
  --cap-add=NET_ADMIN \
  -e ServerIP="$IP" \
  -v $HOME/docker-data/pihole/var/log/pihole.log:/var/log/pihole.log \
  -v $HOME/docker-data/pihole/etc/pihole/:/etc/pihole/ \
  --restart=always \
  --name pihole \
  -d "$IMAGE"

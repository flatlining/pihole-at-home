#!/bin/bash

# Recommended auto ad list updates & log rotation:
wget -O- https://raw.githubusercontent.com/diginc/docker-pi-hole/master/docker-pi-hole.cron | sudo tee /etc/cron.d/docker-pi-hole

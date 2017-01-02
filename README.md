# pihole at home

Based on https://github.com/diginc/docker-pi-hole

## Instructions

1. If you are not using [Hypriot OS](https://blog.hypriot.com/downloads/) install [Docker](https://www.raspberrypi.org/blog/docker-comes-to-raspberry-pi/) on your Raspberry Pi
1. Clone this repo
1. Make sure the Pi is configured to a static IP
1. Run `docker-run.sh`
1. If you want to add the cron job to update the block list run `add-cron-job.sh`
1. Configure your router/devices to use the Pi IP as DNS server

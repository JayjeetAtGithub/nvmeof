#!/bin/bash
set -e

target_ip=$2

# load the nvme/nvmet kernel modules
sudo modprobe nvme
sudo modprobe nvme-tcp
sudo modprobe nvmet
sudo modprobe nvmet-tcp

# install nvme-cli
sudo apt install nvme-cli

# discover the target nvme device
sudo nvme discover -t tcp -a ${target_ip} -s 4420
sudo nvme connect -t tcp -n nvmet-test -a ${target_ip} -s 4420

# Check if the target nvme device is connected
sudo nvme list
sudo lsblk

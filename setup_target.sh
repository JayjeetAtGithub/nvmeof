#!/bin/bash
set -e

device=$1
target_ip=$2

# load the nvme/nvmet kernel modules
sudo modprobe nvme
sudo modprobe nvme-tcp
sudo modprobe nvmet
sudo modprobe nvmet-tcp

# install nvme-cli
sudo apt install nvme-cli

# mount configfs, the kernel use configuration system
sudo /bin/mount -t configfs none /sys/kernel/config/ || true

# create and configure the nvmet subsystem
sudo mkdir /sys/kernel/config/nvmet/subsystems/nvmet-test
cd /sys/kernel/config/nvmet/subsystems/nvmet-test
echo 1 | sudo tee -a attr_allow_any_host > /dev/null
sudo mkdir namespaces/1
cd namespaces/1/
echo -n /dev/${device} | sudo tee -a device_path > /dev/null
echo 1 | sudo tee -a enable > /dev/null
sudo mkdir /sys/kernel/config/nvmet/ports/1
cd /sys/kernel/config/nvmet/ports/1
echo ${target_ip} |sudo tee -a addr_traddr > /dev/null
echo tcp | sudo tee -a addr_trtype > /dev/null
echo 4420 | sudo tee -a addr_trsvcid > /dev/null
echo ipv4 | sudo tee -a addr_adrfam > /dev/null

sudo ln -s /sys/kernel/config/nvmet/subsystems/nvmet-test/ /sys/kernel/config/nvmet/ports/1/subsystems/nvmet-test

# verify the subsystem is created
sudo dmesg | grep "nvmet_tcp"

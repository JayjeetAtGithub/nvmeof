# NVMe over TCP

**NOTE:** Linux kernel 5.0 or later is required with the kernel built with the following configuration on both the target and the host.

```bash
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_RDMA=m
CONFIG_NVME_TCP=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_TCP=m
```

```bash
# On the target,
./setup_target.sh /dev/nvme0n1 10.10.1.2

# On the host,
./setup_host.sh 10.10.1.2
```

Credits: https://www.linuxjournal.com/content/data-flash-part-iii-nvme-over-fabrics-using-tcp

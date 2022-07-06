#!/bin/bash
set -e
/usr/sbin/pvcreate -ff -y /dev/nvme0n1p5
/usr/sbin/vgcreate csi-lvm /dev/nvme0n1p5

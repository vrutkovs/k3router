#!/bin/bash
set -e
/usr/local/bin/setup-loopback.sh
/usr/bin/rpm-ostree install --apply-live https://github.com/k3s-io/k3s-selinux/releases/download/v1.1.stable.1/k3s-selinux-1.1-1.el8.noarch.rpm
curl -sfL https://get.k3s.io | sh -s - --disable=traefik --disable=servicelb --flannel-backend=host-gw --flannel-iface=k3s-lo
/usr/bin/sleep 30
/usr/local/bin/install-olm.sh
/usr/local/bin/install-custom-os.sh
/usr/local/bin/prepare-lvm.sh

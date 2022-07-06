#!/bin/bash
set -e
/usr/bin/skopeo inspect docker://quay.io/vrutkovs/routernetes-os:latest -n -f "{{.Name}}@{{.Digest}}" > /etc/os-digest
/usr/bin/rpm-ostree rebase --experimental ostree-unverified-registry:$(cat /etc/os-digest) --bypass-driver
touch /etc/.k3s-installed
reboot

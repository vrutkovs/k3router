#!/bin/bash
set -e

rm -f routernetes.iso
rm -rf workdir
mkdir -p workdir
docker run --privileged --pull=always --rm -v ./workdir:/data -w /data quay.io/coreos/coreos-installer:release download -f iso -C /data
docker run --interactive --pull=always --rm -v .:/data -w /data --security-opt label=disable quay.io/coreos/butane:release --pretty --strict -o /data/workdir/config.ign butane.yaml
docker run --interactive --privileged --rm -v ./workdir:/data -w /data --entrypoint=bash quay.io/coreos/coreos-installer:release -c "coreos-installer iso customize \
    --dest-device /dev/nvme0n1 \
    --dest-ignition /data/config.ign \
    -o /data/routernetes.iso /data/fedora-coreos-*-live.x86_64.iso"
echo "Wrote $(pwd)/routernetes.iso"

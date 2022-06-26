Routernetes config
====

This repo contains OS configurations and apps to run at a single node acting as a firewall/router.
Applications are controlled by ArgoCD, OS configs are controlled by rpm-ostree.

# OS

`os/` subfolder contains Dockerfile, which uses [CoreOS layering](https://github.com/coreos/coreos-layering-examples) to install necessary packages, prepare services and layer files on the host. One of the services it installs is `autoupdate`, which pulls new image updates and applies them on the host. `rpm-ostree` requires reboot, so the service runs at 04:00.

# Applications

`apps/` subfolder contains ArgoCD apps to run in the cluster

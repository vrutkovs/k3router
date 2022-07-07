k3router
====

`k3router` allows you to contol your router using k8s API.

This repo contains OS configurations and apps to run at a single node acting as a firewall/router.
Applications are controlled by ArgoCD, OS configs are controlled by rpm-ostree.

# ISO
`iso/` subfolder has a script to create a boot image. It would download latest FCOS stable, create Ignition from Butane config and create a bootable ISO. On boot `install-k3s.service` would install k3s binaries, install OLM and apply updates from a custom OS image (see below)

# OS

`os/` subfolder contains Dockerfile, which uses [CoreOS layering](https://github.com/coreos/coreos-layering-examples) to install necessary packages, prepare services and layer files on the host. One of the services it installs is `autoupdate`, which pulls new image updates and applies them on the host. `rpm-ostree` requires reboot, so the service runs at 04:00.

Custom OS image layers bootstrap ArgoCD manifests, which get applied by k3s on boot, configuring the cluster to use manifests from `apps/`

# Applications

`apps/` subfolder contains ArgoCD apps to run in the cluster

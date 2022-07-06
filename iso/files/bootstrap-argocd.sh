#!/bin/bash
set -e
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
/usr/local/bin/kubectl label nodes --all node-role.kubernetes.io/master="" --overwrite
/usr/local/bin/kubectl apply -f /usr/share/gitops-bootstrap
touch /etc/.argocd-installed

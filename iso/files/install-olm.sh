#!/bin/bash
set -e
export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')
export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/latest/download
curl -L -o /usr/local/bin/operator-sdk ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}
chmod +x /usr/local/bin/operator-sdk
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
/usr/local/bin/operator-sdk olm install
/usr/bin/sleep 30
/usr/local/bin/kubectl wait --timeout=24h --for=jsonpath='{.status.connectionState.lastObservedState}'=READY -n olm catalogsource/operatorhubio-catalog
/usr/local/bin/kubectl label namespace operators topolvm.cybozu.com/webhook=ignore

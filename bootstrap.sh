/usr/local/bin/kubectl apply -f https://operatorhub.io/install/argocd-operator.yaml
/usr/bin/sleep 30
/usr/local/bin/kubectl wait --timeout=24h --for=jsonpath='{.status.state}'=AtLatestKnown -n operators sub/my-argocd-operator
csv=$(/usr/local/bin/kubectl get -n operators sub/my-argocd-operator -o jsonpath='{.status.installedCSV}')
/usr/bin/sleep 30
/usr/local/bin/kubectl wait --timeout=24h --for=jsonpath='{.status.phase}'=Succeeded -n operators csv/$csv
/usr/local/bin/kubectl apply -f https://raw.githubusercontent.com/vrutkovs/k3router/main/bootstrap.yaml

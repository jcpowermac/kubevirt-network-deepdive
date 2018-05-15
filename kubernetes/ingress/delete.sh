#!/bin/bash

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/namespace.yaml \
    | kubectl delete -f -

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/default-backend.yaml \
    | kubectl delete -f -

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/configmap.yaml \
    | kubectl delete -f -

# Enable nginx VTS Status
kubectl patch cm nginx-configuration --type merge -p '{"data":{"enable-vts-status":"true"}}' -n ingress-nginx


curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/tcp-services-configmap.yaml \
    | kubectl delete -f -

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/udp-services-configmap.yaml \
    | kubectl delete -f -

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/rbac.yaml \
    | kubectl delete -f -


kubectl delete -f with-rbac.yaml

kubectl delete -f service-nodeport.yaml

kubectl delete -f ngnix-status-ingress.yaml


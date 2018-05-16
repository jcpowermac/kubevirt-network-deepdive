#!/bin/bash

# *NOTE* 
# Mandatory commands
# https://kubernetes.github.io/ingress-nginx/deploy/#mandatory-commands

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/namespace.yaml \
    | kubectl apply -f -

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/default-backend.yaml \
    | kubectl apply -f -

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/configmap.yaml \
    | kubectl apply -f -
    
curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/tcp-services-configmap.yaml \
    | kubectl apply -f -

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/udp-services-configmap.yaml \
    | kubectl apply -f -

# *NOTE*
# Enable nginx VTS Status
kubectl patch cm nginx-configuration --type merge -p '{"data":{"enable-vts-status":"true"}}' -n ingress-nginx

# *NOTE*
# Use RBAC

curl https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/rbac.yaml \
    | kubectl apply -f -

# *NOTE*
# Modifications to support VTS Status

kubectl apply -f with-rbac.yaml

kubectl apply -f service-nodeport.yaml

kubectl apply -f ngnix-status-ingress.yaml

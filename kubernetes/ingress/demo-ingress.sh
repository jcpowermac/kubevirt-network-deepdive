#!/bin/bash

source /tmp/demo-magic/demo-magic.sh

PROMPT_TIMEOUT=1

clear

pe "echo Mandatory Commands"
pe "echo https://kubernetes.github.io/ingress-nginx/deploy/#mandatory-commands"

pe "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/namespace.yaml"
pe "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/default-backend.yaml"
pe "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/configmap.yaml"
pe "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/tcp-services-configmap.yaml"
pe "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/udp-services-configmap.yaml"

pe "echo Enable nginx VTS Status"
pe "kubectl patch cm nginx-configuration --type merge -p '{\"data\":{\"enable-vts-status\":\"true\"}}' -n ingress-nginx"

pe "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/rbac.yaml"

pe "kubectl apply -f with-rbac.yaml"
pe "kubectl apply -f service-nodeport.yaml"
pe "kubectl apply -f ngnix-status-ingress.yaml"

pe "kubectl get pod -n ingress-nginx"
pe "kubectl get all -n ingress-nginx"

pe "echo nginx deployed"
pe "ssh -t jcallen@172.31.51.52 \"DISPLAY=:0 firefox -new-tab -url http://mgmt.ingress.virtomation.com:32000/nginx_status\"
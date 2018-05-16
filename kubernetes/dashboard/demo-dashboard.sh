#!/bin/bash

source /tmp/demo-magic/demo-magic.sh

PROMPT_TIMEOUT=1

clear

p "Install Kubernetes Dashboard"
pe "kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml"

p "Create Ingress for Dashboard"
pe "kubectl create -f ingress.yaml"

p "Check pods..."
pe "kubectl get pod -n kube-system"
p "Check ingress..."
pe "kubectl get ingress -n kube-system"
p "Check deployments..."
pe "kubectl get deploy -n kube-system"

pe "firefox -new-tab -url https://dashboard.ingress.virtomation.com:30443"

#!/bin/bash

source /tmp/demo-magic/demo-magic.sh

PROMPT_TIMEOUT=1

clear

p "Confirming KubeVirt is running"
p "Check Pods..."
pe "kubectl get pod -n kube-system"
p "Check Deployments..."
pe "kubectl get deploy -n kube-system"
p "Check DaemonSets..."
pe "kubectl get ds -n kube-system"

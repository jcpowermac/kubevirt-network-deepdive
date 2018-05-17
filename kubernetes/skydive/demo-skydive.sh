#!/bin/bash

source /tmp/demo-magic/demo-magic.sh

PROMPT_TIMEOUT=1

clear

p "Install Skydive"

pe "kubectl create ns skydive"
pe "kubectl create -n skydive -f https://raw.githubusercontent.com/skydive-project/skydive/master/contrib/kubernetes/skydive.yaml"
pe "kubectl create -n skydive -f ingress.yaml"

pe "kubectl get pod -n skydive"

pe "ssh -t jcallen@172.31.51.52 'DISPLAY=:0 firefox -new-tab -url http://skydive.ingress.virtomation.com:30000'"
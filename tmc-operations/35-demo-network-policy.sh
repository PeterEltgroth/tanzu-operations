#!/bin/bash

########################
# include the magic
########################
. demo-magic.sh

########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=20

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear

cluster_name=tmc-production-cluster

#NETWORK POLICY
DEMO_PROMPT="${GREEN}➜ TMC NETWORK POLICY ${CYAN}\W "

pe "kubectl config use-context ${cluster_name}"
echo

pe "kubectl run nginx-api --image nginx -n production-api --labels tier=api"
echo

pe "kubectl run nginx-app --image nginx -n production-app --labels tier=app"
echo

pe "kubectl run nginx-data --image nginx -n production-data --labels tier=data"
echo

pe "clear"

pe "kubectl get pods -A -o wide"
echo

pe "kubectl exec nginx-api -it -n production-api -- sh"
echo

pe "clear"

pe "tmc workspace network-policy create -f tmc/configs/network-policy.yaml --dry-run"
echo

pe "clear"

pe "tmc workspace network-policy create -f tmc/configs/network-policy.yaml"
echo

pe "watch kubectl get networkpolicies -A"
echo

pe "kubectl get pods -A -o wide"
echo

pe "kubectl exec nginx-api -it -n production-api -- sh"
echo

pe "kubectl exec nginx-app -it -n production-app -- sh"
echo

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


#NETWORK POLICY
DEMO_PROMPT="${GREEN}➜ TMC NETWORK POLICY ${CYAN}\W "

pe "kubectl run nginx-web --image nginx -n network --labels tier=web"
echo

pe "kubectl run nginx-app --image nginx -n network --labels tier=app"
echo

pe "kubectl run nginx-data --image nginx -n network --labels tier=data"
echo
clear

pe "kubectl get pods -n network -o wide"
echo

pe "kubectl exec nginx-web -it -n network -- sh"
echo

pe "tmc workspace network-policy create -f tmc/configs/network-policy.yaml --dry-run"
echo

pe "tmc workspace network-policy create -f tmc/configs/network-policy.yaml"
echo

pe "watch kubectl get networkpolicies -n network"
echo

pe "kubectl exec nginx-web -it -n network -- sh"
echo

pe "kubectl exec nginx-app -it -n network -- sh"
echo

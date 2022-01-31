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


#REGISTRY POLICY
DEMO_PROMPT="${GREEN}➜ TMC REGISTRY POLICY ${CYAN}\W "

pe "kubectl get pods -n registry"
echo

pe "kubectl run docker-nginx-web --image nginx -n registry"
echo

pe "kubectl get pods -n registry"
echo

pe "kubectl delete pod docker-nginx-web -n registry"
echo

pe "tmc workspace image-policy create -f tmc/configs/registry-policy.yaml --dry-run"
echo

pe "clear"

pe "tmc workspace image-policy create -f tmc/configs/registry-policy.yaml"
echo

pe "watch kubectl get pods -n gatekeeper-system"
echo

pe "kubectl run docker-nginx-web --image nginx -n registry"
echo

pe "kubectl get pods -n registry"
echo

pe "kubectl run gcr-nginx-web --image gcr.io/google-containers/nginx -n registry"
echo

pe "kubectl get pods -n registry"
echo
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

cluster_name=tmc-staging-cluster


#QUOTA POLICY
DEMO_PROMPT="${GREEN}➜ TMC QUOTA POLICY ${CYAN}\W "
echo

pe "kubectl config use-context ${cluster_name}"
echo

pe "kubectl get pods"
echo

pe "tmc clustergroup namespace-quota-policy create -f tmc/configs/quota-policy.yaml --dry-run"
echo

pe "clear"

pe "tmc clustergroup namespace-quota-policy create -f tmc/configs/quota-policy.yaml"
echo

#QUOTA POLICY
pe "cat tmc/configs/quota-exceeds.yaml"
echo

pe "kubectl apply -f tmc/configs/quota-exceeds.yaml"
echo

pe "clear"

pe "kubectl get events | grep FailedCreate"
echo

pe "kubectl get pods"
echo

pe "clear"

pe "cat tmc/configs/quota-within.yaml"
echo

pe "kubectl apply -f tmc/configs/quota-within.yaml"
echo

pe "kubectl get pods"
echo

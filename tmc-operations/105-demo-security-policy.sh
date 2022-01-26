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

tmc_security_cluster=tmc-security-cluster


#QUOTA/SECURITY POLICY (AKS & QUOTA POLICY)
DEMO_PROMPT="${GREEN}➜ TMC QUOTA/SECURITY POLICY ${CYAN}\W "
echo

pe "kubectl config use-context ${tmc_security_cluster}"
echo


#SECURITY
pe "tmc clustergroup security-policy create -f tmc/configs/security-policy.yaml --dry-run"
echo

pe "tmc clustergroup security-policy create -f tmc/configs/security-policy.yaml"
echo

pe "kubectl run nginx --image nginx"
echo

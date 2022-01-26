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

quota_group=quota-group
tmc_security_cluster=tmc-security-cluster


#QUOTA/SECURITY POLICY (AKS & QUOTA POLICY)
DEMO_PROMPT="${GREEN}➜ TMC QUOTA/SECURITY POLICY ${CYAN}\W "
echo

pe "kubectl config use-context ${tmc_security_cluster}"
echo

pe "kubectl get pods"
echo

#QUOTA POLICY
pe "cat tmc/configs/quota-exceeds.yaml"
echo

pe "kubectl apply -f tmc/configs/quota-exceeds.yaml"
echo

pe "kubectl get events | grep FailedCreate"
echo

pe "kubectl get pods"
echo
clear

pe "kubectl apply -f tmc/configs/quota-within.yaml"
echo

pe "kubectl get pods"
echo

pe "kubectl delete deployment quota-within"
echo

pe "tmc clustergroup namespace-quota-policy delete quota-policy --cluster-group-name ${quota_group}"
echo

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

cluster_group=cluster-group
quota_cluster=quota-cluster


#QUOTA POLICY
DEMO_PROMPT="${GREEN}➜ TMC QUOTA POLICY ${CYAN}\W "
echo

pe "kubectl config use-context ${quota_cluster}"
echo

pe "tmc clustergroup namespace-quota-policy create -f tmc/configs/quota-policy.yaml --dry-run"
echo

pe "tmc clustergroup namespace-quota-policy create -f tmc/configs/quota-policy.yaml"
echo

pe "cat tmc/configs/exceeds-quota.yaml"
echo

pe "kubectl apply -f tmc/configs/exceeds-quota.yaml"
echo

pe "kubectl get events"
echo

pe "kubectl get pods"
echo

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

quota_cluster_group=quota-cluster-group
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


#SECURITY
pe "kubectl apply -f tmc/configs/quota-within.yaml"
echo

pe "kubectl get pods"
echo

pe "kubectl delete deployment quota-within"
echo

pe "tmc clustergroup security-policy create -f tmc/configs/security-policy.yaml --dry-run"
echo

pe "tmc clustergroup security-policy create -f tmc/configs/security-policy.yaml"
echo

pe "kubectl apply -f tmc/configs/quota-within.yaml"
echo

pe "kubectl delete deployment quota-within"
echo

pe "tmc clustergroup security-policy delete security-policy --cluster-group-name cluster-group"
echo



#DEMO_PROMPT="${GREEN}➜ TOS ${CYAN}\W "

#pe "helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update"
#echo

#pe "kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=f56e75ef-5ca0-41f8-ab2a-1693f55714ed --set clusterName="tanzu-cluster-nginx-dev-eu-west-1" --namespace wavefront"
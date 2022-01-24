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

read -p "Azure Subscription: " subscription

TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login

cluster_group=default-cluster-group
access_cluster_group=access-cluster-group
quota_cluster_group=quota-cluster-group
custom_cluster_group=custom-cluster-group
security_cluster_group=registry-and-network-cluster


#ACCESS POLICY
DEMO_PROMPT="${GREEN}➜ TMC ACCESS POLICY ${CYAN}\W "
echo


#QUOTA POLICY
DEMO_PROMPT="${GREEN}➜ TMC QUOTA POLICY ${CYAN}\W "
echo

pe "kubectl config use-context ${quota_cluster_group}"
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


#CUSTOM POLICY
DEMO_PROMPT="${GREEN}➜ TMC CUSTOM POLICY ${CYAN}\W "
echo


#SECURITY POLICY (AKS & QUOTA POLICY)
DEMO_PROMPT="${GREEN}➜ TMC SECURITY POLICY ${CYAN}\W "
echo

pe "kubectl config use-context $security_cluster_group"
echo

pe "tmc cluster attach --name ${security_cluster_group} --cluster-group ${cluster_group}"
echo

pe "kubectl apply -f ./k8s-attach-manifest.yaml"

pe "Press Enter to continue"
clear






#DEMO_PROMPT="${GREEN}➜ TOS ${CYAN}\W "

#pe "helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update"
#echo

#pe "kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=f56e75ef-5ca0-41f8-ab2a-1693f55714ed --set clusterName="tanzu-cluster-nginx-dev-eu-west-1" --namespace wavefront"
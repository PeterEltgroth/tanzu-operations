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

registry_and_network_cluster=gke-security-cluster-group
registry_workspace=registry-workspace
network_workspace=network-workspace

DEMO_PROMPT="${GREEN}➜ TMC ATTACH CLUSTERS ${CYAN}\W "
echo


#CREATE REGISTRY AND NETWORK CLUSTER
#THESE ARE ATTACHED TO THE WORKSPACE
pe "kubectl config use-context ${registry_and_network_cluster}"
echo

read -p "Manual attachment command: " attach_command

pe "${attach_command}"
echo


#CREATE WORKSPACES
pe "tmc workspace create --name ${registry_workspace} --description 'Demonstrates an image registry policy applicable to all namespaces therein.'"
echo

pe "tmc workspace create --name ${network_workspace} --description 'Demonstrates a network policy between two pods from any image registry.'"
echo

read -p "Awaiting cluster attachments..."


#CREATE NAMESPACES
pe "tmc cluster namespace create -f tmc/configs/registry-namespace.yaml"
echo

pe "tmc cluster namespace create -f tmc/configs/network-namespace.yaml"
echo

read -p "Press Enter to continue"
clear


#TMC
DEMO_PROMPT="${GREEN}➜ TMC REGISTRY POLICY ${CYAN}\W "


#REGISTRY POLICY
pe "kubectl get pods -n registry"
echo

pe "kubectl run docker-nginx-web --image nginx -n registry"
echo

pe "kubectl delete pod docker-nginx-web -n registry"
echo

pe "tmc workspace image-policy create -f tmc/configs/registry-policy.yaml --dry-run"
echo

pe "tmc workspace image-policy create -f tmc/configs/registry-policy.yaml"
echo

pe "kubectl run docker-nginx-web --image nginx -n registry"
echo

pe "kubectl get pods -n registry"
echo

pe "kubectl run gcr-nginx-web --image gcr.io/google-containers/nginx -n registry"
echo

pe "kubectl get pods -n registry"
echo


#NETWORK POLICY
DEMO_PROMPT="${GREEN}➜ TMC NETWORK POLICY ${CYAN}\W "

pe "kubectl run nginx-web --image nginx -n network --labels tier=web"
echo

pe "kubectl run nginx-data --image nginx -n network"
echo

pe "kubectl get pods -n network"
echo

pe "kubectl get pods -n network -o wide"
echo

pe "kubectl exec nginx-web -it -n network -- sh"
echo

pe "tmc workspace network-policy create -f tmc/configs/network-policy.yaml --dry-run"
echo

pe "tmc workspace network-policy create -f tmc/configs/network-policy.yaml"
echo

pe "kubectl exec nginx-web -it -n network -- sh"
echo

pe "kubectl get networkpolicies -n network"
echo

read -p "Network Policy Name: " network_policy
echo

pe "kubectl get networkpolicy ${network_policy} -n network -o yaml"
echo


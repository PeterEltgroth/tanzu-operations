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

workspace_group=workspace-group
registry_workspace=registry-workspace
network_workspace=network-workspace
tmc_registry_and_network_cluster=tmc-registry-and-network-cluster

DEMO_PROMPT="${GREEN}➜ TMC ATTACH CLUSTERS ${CYAN}\W "
echo

#CREATE CLUSTER GROUP
pe "tmc clustergroup create --name ${workspace_group} --description 'Demonstrates the workspace-only policies; image registry and network.'"
echo

#CREATE REGISTRY AND NETWORK CLUSTER
#THESE ARE ATTACHED TO THE WORKSPACE
pe "kubectl config use-context ${tmc_registry_and_network_cluster}"
echo

read -p "Retrieve command from portal: " attach_command

pe "${attach_command}"
echo

pe "clear"

#CREATE WORKSPACES
pe "tmc workspace create --name ${registry_workspace} --description 'Demonstrates an image registry policy applicable to all namespaces therein.'"
echo

pe "tmc workspace create --name ${network_workspace} --description 'Demonstrates a network policy between two pods from any image registry.'"
echo


#CREATE NAMESPACES
pe "kubectl get ns"
echo

pe "tmc cluster namespace create -f tmc/configs/registry-namespace.yaml"
echo

pe "tmc cluster namespace create -f tmc/configs/network-namespace.yaml"
echo

pe "kubectl get ns"
echo


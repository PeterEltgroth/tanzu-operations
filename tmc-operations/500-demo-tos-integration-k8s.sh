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


#CUSTOM POLICY
DEMO_PROMPT="${GREEN}➜ TOS ${CYAN}\W "
echo


cluster_name=tmc-custom-cluster

wavefront_token=$(az keyvault secret show --name wavefront-token --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

pe "kubectl config use-context ${cluster_name}"
echo

#pe "helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update"
#echo

#pe "kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${cluster_name} --namespace wavefront"
#echo

pe "kubectl apply -f tmc/configs/tos-node-stressor.yaml"
echo


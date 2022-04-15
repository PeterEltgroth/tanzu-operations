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

read -p "Azure subscription: " subscription
read -p "Cluster Name: " cluster_name
echo

TSM_API_TOKEN=$(az keyvault secret show --name tsm-token-mapbu --subscription $subscription --vault-name tanzuvault --query value --output tsv)

pe "kubectl config use-context ${cluster_name}"
echo

rm tmc/configs/integration-tsm-${cluster_name}.yaml
cat <<EOF | tee tmc/configs/integration-tsm-${cluster_name}.yaml
fullName:
  name: tanzu-service-mesh
  clusterName: $cluster_name
  managementClusterName: attached
  provisionerName: attached
spec:
  configurations:
    clusterName: $cluster_name
    enableNamespaceExclusions: true
  secrets:
    token: $TSM_API_TOKEN
EOF

pe "tmc cluster integration create -f tmc/configs/integration-tsm-${cluster_name}.yaml"
echo

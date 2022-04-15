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
TYPE_SPEED=15

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear

DEMO_PROMPT="${GREEN}➜ TMC ${CYAN}\W "

subscription=nycpivot

tmc_build_cluster=tmc-build-cluster
tmc_development_cluster=tmc-development-cluster
tmc_staging_cluster=tmc-staging-cluster

wavefront_token=$(az keyvault secret show --name wavefront-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

#HOLD OFF TILL IT CAN BE DETERMINED HOW TO GET THE KUBECONFIG FOR A PROVISIONED TMC CLUSTER
#ADD TO BUILD CLUSTER
#kubectl config use-context ${tmc_build_cluster}-admin@${tmc_build_cluster}

#helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update

#kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${tmc_build_cluster} --namespace wavefront


#ADD TO DEVELOPMENT CLUSTER
pe "kubectl config use-context ${tmc_development_cluster}"
echo

pe "helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update"
echo

pe "kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${tmc_development_cluster} --namespace wavefront"
echo


#ADD TO STAGING CLUSTER
pe "kubectl config use-context ${tmc_staging_cluster}"
echo

pe "helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update"
echo

pe "kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${tmc_staging_cluster} --namespace wavefront"
echo

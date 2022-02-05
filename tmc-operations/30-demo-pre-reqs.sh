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

production_cluster_group=production-cluster-group
web_workspace=web-workspace
app_workspace=app-workspace

tmc_production_cluster=tmc-production-cluster


DEMO_PROMPT="${GREEN}➜ TMC ATTACH CLUSTERS ${CYAN}\W "
echo

#CREATE PRODUCTION CLUSTER GROUP
pe "tmc clustergroup create --name ${production_cluster_group}"
echo

#ATTACH PRODUCTION CLUSTER MANUALLY
pe "kubectl config use-context ${tmc_production_cluster}"
echo

read -p "Retrieve command from portal: " attach_command

pe "${attach_command}"
echo

pe "clear"


#CREATE WORKSPACES
pe "tmc workspace create --name ${web_workspace} --description 'Demonstrates an image registry policy applicable to all namespaces therein.'"
echo

pe "tmc workspace create --name ${app_workspace} --description 'Demonstrates microsegmentation between pods.'"
echo


#CREATE NAMESPACES
pe "kubectl get ns"
echo

pe "tmc cluster namespace create -f tmc/configs/namespace-web.yaml"
echo

pe "tmc cluster namespace create -f tmc/configs/namespace-api.yaml"
echo

pe "tmc cluster namespace create -f tmc/configs/namespace-app.yaml"
echo

pe "tmc cluster namespace create -f tmc/configs/namespace-data.yaml"
echo

pe "kubectl get ns"
echo


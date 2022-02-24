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

DEMO_PROMPT="${GREEN}➜ TBS ${CYAN}\W "

pe "kubectl config get-contexts"
echo

read -p "Cluster name: " cluster_name

pe "kubectl config use-context ${cluster_name}"
echo

pe "kp image delete spring-petclinic"
echo

pe "kp image list"
echo

pe "clear"


#CREATE IMAGES NOW - DURING EXECUTION EXPLAIN COMMAND PARAMS, LIST ALL TARGET CLUSTERS, CHECK STATUS or CHECK BUILD LOGS
pe "kp image create spring-petclinic --tag tanzubuildservice.azurecr.io/tanzu-spring-petclinic --git https://github.com/nycpivot/tanzu-spring-petclinic" #--sub-path src/GitLab.Dotnet.Core.Web
echo

pe "clear"
echo

pe "kp image status spring-petclinic"
echo

pe "kp build logs spring-petclinic"
echo
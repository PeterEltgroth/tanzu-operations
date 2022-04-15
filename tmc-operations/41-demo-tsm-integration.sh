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

read -p "Cluster Name: " cluster_name

pe "kubectl config use-context ${cluster_name}"
echo

pe "tmc cluster integration create -f tmc/configs/integration-tsm.yaml"
echo

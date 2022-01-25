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

access_cluster_group=access-cluster-group


#ACCESS POLICY
DEMO_PROMPT="${GREEN}➜ TMC ACCESS POLICY ${CYAN}\W "
echo

pe "tmc organization iam add-binding -u mjames@developerthejameshome.onmicrosoft.com -r organization.view"
echo

pe "kubectl run nginx --image nginx"
echo

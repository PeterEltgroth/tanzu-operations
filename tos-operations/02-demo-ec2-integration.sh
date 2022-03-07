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

DEMO_PROMPT="${GREEN}➜ TOS ${CYAN}\W "

pe "aws ec2 describe-instances --filters 'Name=tag:Name,Values=tos-operator-us-east-2' | jq '.Reservations | .[] | .Instances | .[] | { InstanceId: .InstanceId, Name: .Tags[0].Value }'"
echo

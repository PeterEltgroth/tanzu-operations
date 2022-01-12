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


DEMO_PROMPT="${GREEN}➜ TAP ${CYAN}\W "

read -p "App Name: " app_name
read -p "Git App Url: " git_app_url
echo

pe "tanzu apps workload delete --all"
echo

pe "tanzu apps workload list"
echo

pe "tanzu apps workload create ${app_name} --git-repo ${git_app_url} --git-branch main --type web --label app.kubernetes.io/part-of=${app_name} --yes --dry-run"
echo

pe "tanzu apps workload create ${app_name} --git-repo ${git_app_url} --git-branch main --type web --label app.kubernetes.io/part-of=${app_name} --yes"
echo

pe "tanzu apps workload tail ${app_name} --since 10m --timestamp"
echo

pe "tanzu apps workload list"
echo

pe "tanzu apps workload get ${app_name}"


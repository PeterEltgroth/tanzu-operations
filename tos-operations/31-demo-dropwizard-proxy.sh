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

subscription=nycpivot
project_name=02-dropwizard-proxy

wavefront_prod_token=$(az keyvault secret show --name wavefront-prod-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export JAVA_HOME=/usr/lib/java/jdk-17
export PATH=$PATH:/usr/lib/java/jdk-17/bin
export PATH=$PATH:/usr/lib/maven/apache-maven-3.8.4/bin

pe "cat tos/tanzu-observability/${project_name}/pom.xml"
echo
	
cd tos/tanzu-observability/${project_name}
		
pe "mvn clean install"

pe "Start supporting services (shopping, styling, delivery)"
echo
	
bash ./loadgen.sh 60

cd $HOME

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

echo "PROJECTS LIST:"
echo "1) spring-petclinic-opentracing-freemium"
echo "2) spring-petclinic-sleuth-freemium"
echo "3) spring-petclinic-jaeger-freemium"
echo

read -p "Input Project Number: " project_number
project_name="spring-petclinic-opentracing-freemium"

if [ "${project_number}" == "1" ]
then
	project_name=spring-petclinic-opentracing-freemium
elif [ "${project_number}" == "2" ]
then
	project_name=spring-petclinic-sleuth-freemium
elif [ "${project_number}" == "3" ]
then
	project_name=spring-petclinic-jaeger-freemium
fi

subscription=nycpivot

wavefront_sandbox_token=$(az keyvault secret show --name wavefront-sandbox-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export JAVA_HOME=/usr/lib/java/jdk-17
export PATH=$PATH:/usr/lib/java/jdk-17/bin
export PATH=$PATH:/usr/lib/maven/apache-maven-3.8.4/bin

cd tos
pe "rm -rf tanzu-observability"
echo

pe "git clone https://github.com/nycpivot/tanzu-observability"
echo

pe "cat tanzu-observability/${project_name}/pom.xml"
echo

#cat <<EOF | tee -a tanzu-observability/${project_name}/src/main/resources/application.properties

#management.metrics.export.wavefront.uri=https://vmware.wavefront.com
#management.metrics.export.wavefront.api-token=${wavefront_sandbox_token}
#EOF

pe "cat tanzu-observability/${project_name}/src/main/resources/application.properties"
echo

cd ${HOME}/tos/tanzu-observability/${project_name}
echo

chmod +x mvnw
pe "./mvnw spring-javaformat:apply"
echo

pe "./mvnw spring-boot:run"

cd $HOME

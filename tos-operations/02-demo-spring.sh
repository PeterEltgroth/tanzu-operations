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

export JAVA_HOME=/usr/lib/java/jdk-17
export PATH=$PATH:/usr/lib/java/jdk-17/bin
export PATH=$PATH:/usr/lib/maven/apache-maven-3.8.4/bin

read -p "Repository Name: " repo_name

if [ -z $repo_name ]
then
	repo_name=tanzu-spring-petclinic
fi

pe "cd tos"
pe "rm -rf ${repo_name}"
echo

pe "git clone https://github.com/nycpivot/${repo_name}"
echo

pe "cd ${repo_name}"
echo

pe "cat pom.xml | grep wavefront"
echo

pe "cd src/main/resources"
pe "cat application.properties | grep wavefront"
echo

pe "cd ${HOME}/tos/${repo_name}"
echo

chmod +x mvnw
pe "./mvnw spring-boot:run"

cd $HOME

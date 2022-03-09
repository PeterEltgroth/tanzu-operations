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
	
	read -p "Wavefront Url (wavefront.surf): " wavefront_url
	read -p "Proxy Token (14813b68-1037-416d-97fb-a2f3e8f7de99): " proxy_token
	
	if [ -z $wavefront_url ]
	then
		wavefront_url=wavefront.surf
	fi
	
	if [ -z $proxy_token ]
	then
		proxy_token=14813b68-1037-416d-97fb-a2f3e8f7de99
	fi
	
	pe "sudo bash -c \"$(curl -sL https://wavefronthq.github.io/wavefront-cli/install.sh)\" -- install --proxy --wavefront-url https://${wavefront_url} --api-token ${proxy_token}"
	echo
	
	pe "echo -e \"test.metric 1 source=test-host\n\" | nc ${wavefront_url} 2878"
	echo
	
	#sudo cat <<EOF | tee -a /etc/wavefront/wavefront-proxy/wavefront.conf
	#traceJaegerGrpcListenerPorts=6831
	#EOF
	
	pe "sudo lsof -i -P -n | grep LISTEN"
	echo
	
	
	
	
	
	
	
	
	
	pe "docker run jaegertracing/jaeger-agent:latest --reporter.grpc.host-port=localhost:6931"
	echo
	
	#pe "docker run -d --name jaeger -p 5775:5775/udp -p 16686:16686 jaegertracing/all-in-one:latest --reporter.grpc.host-port=localhost:6931"
	#pe "docker run -d --name jaeger -p6831:6831/udp -p16686:16686 jaegertracing/all-in-one:latest --reporter.grpc.host-port=localhost:6931"
	#echo
	
	#pe "docker run --rm --link jaeger --env JAEGER_AGENT_HOST=ip-172-31-42-215 --env JAEGER_AGENT_PORT=2878 -p 8080-8083:8080-8083 jaegertracing/example-hotrod:latest all"
	#echo
	
	#pe "git clone https://github.com/jaegertracing/jaeger.git tos/tanzu-observability/jaeger"
	#echo
	
	#pe "go run tos/tanzu-observability/jaeger/examples/hotrod/main."
	

	
	sudo service wavefront-proxy restart
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

echo management.metrics.export.wavefront.uri=https://vmware.wavefront.com >> tanzu-observability/${project_name}/src/main/resources/application.properties
echo management.metrics.export.wavefront.api-token=${wavefront_sandbox_token} >> tanzu-observability/${project_name}/src/main/resources/application.properties

pe "clear"
pe "cat tanzu-observability/${project_name}/src/main/resources/application.properties"
echo

cd ${HOME}/tos/tanzu-observability/${project_name}
echo

chmod +x mvnw
pe "./mvnw spring-javaformat:apply"
echo

pe "./mvnw spring-boot:run"

cd $HOME

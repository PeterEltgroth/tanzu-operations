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
echo "1) spring-petclinic-opentracing"
echo "2) dropwizard-wavefront"
#echo "3) spring-petclinic-jaeger"
echo

read -p "Input Project Number: " project_number

subscription=nycpivot

wavefront_prod_token=$(az keyvault secret show --name wavefront-prod-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export JAVA_HOME=/usr/lib/java/jdk-17
export PATH=$PATH:/usr/lib/java/jdk-17/bin
export PATH=$PATH:/usr/lib/maven/apache-maven-3.8.4/bin

cd tos
pe "rm -rf tanzu-observability"
echo

pe "git clone https://github.com/nycpivot/tanzu-observability"
echo

cd $HOME

if [ "${project_number}" == "1" ] #OPEN-TRACING
then

	project_name=01-spring-petclinic-opentracing
	
	pe "cat tos/tanzu-observability/${project_name}/pom.xml"
	echo
	
	echo management.metrics.export.wavefront.uri=https://vmwareprod.wavefront.com >> tos/tanzu-observability/${project_name}/src/main/resources/application.properties
	echo management.metrics.export.wavefront.api-token=${wavefront_prod_token} >> tos/tanzu-observability/${project_name}/src/main/resources/application.properties
	
	pe "clear"
	pe "cat tos/tanzu-observability/${project_name}/src/main/resources/application.properties"
	echo
	
	cd ${HOME}/tos/tanzu-observability/${project_name}
	echo

	chmod +x mvnw
	pe "./mvnw spring-javaformat:apply"
	echo

	pe "./mvnw spring-boot:run"
	
elif [ "${project_number}" == "2" ] #DROP-WIZARD
then

	project_name=02-dropwizard-wavefront
	
	pe "cat tos/tanzu-observability/${project_name}/pom.xml"
	echo
	
	cd tos/tanzu-observability/02-dropwizard-wavefront
		
	mvn clean install
	
	java -jar ./shopping/target/shopping-1.0-SNAPSHOT.jar server ./shopping/app.yaml
	java -jar ./styling/target/styling-1.0-SNAPSHOT.jar server ./styling/app.yaml
	java -jar ./delivery/target/delivery-1.0-SNAPSHOT.jar server ./delivery/app.yaml
	
	./loadgen.sh 5
	
elif [ "${project_number}" == "3" ]
then

	project_name=spring-petclinic-jaeger
	
	read -p "Wavefront Url (wavefront.surf): " wavefront_url
	read -p "Proxy Token (14813b68-1037-416d-97fb-a2f3e8f7de99): " proxy_token
	
	if [ -z $wavefront_url ]
	then
		wavefront_url=wavefront.surf
	fi
	
	if [ -z $proxy_token ]
	then
		#proxy_token=14813b68-1037-416d-97fb-a2f3e8f7de99
	fi
	
	#sudo cat <<EOF | tee -a /etc/wavefront/wavefront-proxy/wavefront.conf
	#traceJaegerGrpcListenerPorts=6831
	#EOF
	
	#pe "sudo lsof -i -P -n | grep LISTEN"
	#echo
	
	#pe "docker run jaegertracing/jaeger-agent:latest --reporter.grpc.host-port=localhost:6931"
	#echo
	
	#pe "docker run -d --name jaeger -p 5775:5775/udp -p 16686:16686 jaegertracing/all-in-one:latest --reporter.grpc.host-port=localhost:6931"
	#pe "docker run -d --name jaeger -p6831:6831/udp -p16686:16686 jaegertracing/all-in-one:latest --reporter.grpc.host-port=localhost:6931"
	#echo
	
	#pe "docker run --rm --link jaeger --env JAEGER_AGENT_HOST=ip-172-31-42-215 --env JAEGER_AGENT_PORT=2878 -p 8080-8083:8080-8083 jaegertracing/example-hotrod:latest all"
	#echo
	
	#pe "git clone https://github.com/jaegertracing/jaeger.git tos/tanzu-observability/jaeger"
	#echo
	
	#pe "go run tos/tanzu-observability/jaeger/examples/hotrod/main."
	
fi

cd $HOME

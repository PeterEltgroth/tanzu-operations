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


pe "cat tanzu-java-web-app/src/main/java/com/example/springboot/HelloController.java"
echo

read -p "Message: " message
echo

pe "rm tanzu-java-web-app/src/main/java/com/example/springboot/HelloController.java"
echo

cat <<EOF | tee tanzu-java-web-app/src/main/java/com/example/springboot/HelloController.java
package com.example.springboot;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

	@RequestMapping("/")
	public String index() {
		return "${message}";
	}

}
EOF

read -p "Source Image: " source_image
read -p "Local Path: " local_path
read -p "Namespace: " namespace

pe "export SOURCE_IMAGE='${source_image}'"
pe "export LOCAL_PATH='${local_path}'"
pe "export NAMESPACE='${namespace}'"
echo

pe "cd tanzu-java-web-app"
pe "tilt up"
echo

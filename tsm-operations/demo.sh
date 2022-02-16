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

#TSM
DEMO_PROMPT="${GREEN}➜ TSM ${CYAN}\W "

pe "kubectl config use-context nyc-fitness-web"
echo

pe "kubectl get virtualservices"
echo

pe "kubectl get services -A | grep ingress"
echo
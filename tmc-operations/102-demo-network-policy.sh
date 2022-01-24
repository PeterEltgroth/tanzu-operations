#NETWORK POLICY
DEMO_PROMPT="${GREEN}➜ TMC NETWORK POLICY ${CYAN}\W "

pe "kubectl run nginx-web --image nginx -n network --labels tier=web"
echo

pe "kubectl run nginx-app --image nginx -n network --labels tier=app"
echo

pe "kubectl run nginx-data --image nginx -n network --labels tier=data"
echo

pe "kubectl get pods -n network"
echo

pe "kubectl get pods -n network -o wide"
echo

pe "kubectl exec nginx-web -it -n network -- sh"
echo

pe "tmc workspace network-policy create -f tmc/configs/network-policy.yaml --dry-run"
echo

pe "tmc workspace network-policy create -f tmc/configs/network-policy.yaml"
echo

pe "kubectl exec nginx-web -it -n network -- sh"
echo

pe "kubectl get networkpolicies -n network"
echo

read -p "Network Policy Name: " network_policy
echo

pe "kubectl get networkpolicy ${network_policy} -n network -o yaml"
echo

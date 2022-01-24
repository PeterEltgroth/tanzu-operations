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

read -p "Azure Subscription: " subscription

TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login

cluster_group=default-cluster-group
workspace_group=default-workspace-group
security_cluster_group=gke-security-cluster-group
registry_and_network_cluster=aks-registry-and-network-cluster
registry_workspace=registry-workspace
network_workspace=network-workspace

DEMO_PROMPT="${GREEN}➜ TMC ATTACH CLUSTERS ${CYAN}\W "
echo

#CREATE SECURITY CLUSTER
#THE GKE CLUSTER IS ATTACHED TO THE CLUSTER GROUP
pe "kubectl config use-context $security_cluster_group"
echo

rm ./k8s-attach-manifest.yaml
pe "tmc cluster attach --name ${security_cluster_group} --cluster-group ${cluster_group}"
echo

pe "kubectl apply -f ./k8s-attach-manifest.yaml"
clear


#CREATE REGISTRY AND NETWORK CLUSTER
#THESE ARE ATTACHED TO THE WORKSPACE
pe "kubectl config use-context ${registry_and_network_cluster}"
echo

rm ./k8s-attach-manifest.yaml
#pe "tmc cluster attach --name ${registry_and_network_cluster} --cluster-group ${workspace_group}"
#echo

read -p "Input location to manifest: " attach_manifest

pe "kubectl apply -f ${attach_manifest}"
echo


#CREATE WORKSPACES
pe "tmc workspace create --name ${registry_workspace} --description 'Demonstrates an image registry policy applicable to all namespaces therein.'"
echo

pe "tmc workspace create --name ${network_workspace} --description 'Demonstrates a network policy between two pods from any image registry.'"
echo

read -p "Waiting for cluster attachment..."


#CREATE NAMESPACES
pe "tmc cluster namespace create -f tmc/configs/registry-namespace.yaml"
echo

pe "tmc cluster namespace create -f tmc/configs/network-namespace.yaml"
echo


#TMC
DEMO_PROMPT="${GREEN}➜ TMC REGISTRY POLICY ${CYAN}\W "

registry_and_network_cluster=aks-registry-and-network-cluster


#REGISTRY POLICY
pe "kubectl config use-context ${registry_and_network_cluster}"
echo

pe "kubectl delete pod docker-nginx-web -n registry"
echo

pe "kubectl run docker-nginx-web --image nginx -n registry"
echo

pe "kubectl get pods -n registry"
echo

pe "tmc workspace image-policy create -f tmc/configs/registry-policy.yaml --dry-run"
echo

pe "tmc workspace image-policy create -f tmc/configs/registry-policy.yaml"
echo

pe "kubectl run docker-nginx-web --image nginx -n registry"
echo

pe "kubectl get pods -n registry"
echo

pe "kubectl run gcr-nginx-web --image gcr.io/google-containers/nginx -n registry"
echo

pe "kubectl get pods -n registry"
echo


#NETWORK POLICY
DEMO_PROMPT="${GREEN}➜ TMC NETWORK POLICY ${CYAN}\W "

pe "tmc workspace network-policy create -f tmc/configs/network-policy.yaml"
echo

pe "kubectl run nginx-web --image nginx -n network --labels tier=web"
echo

pe "kubectl run nginx-data --image nginx -n network"
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





#ATTACH TMC-ACCESS-POLICY
#cluster_name="tmc-access-policy"
#pe "kubectl config use-context arn:aws:eks:us-west-1:964978768106:cluster/${cluster_name}"
#echo

#pe "kubectl get ns"
#echo

#rm ./k8s-attach-manifest.yaml
#pe "tmc cluster attach --name ${cluster_name} --cluster-group security"
#echo

#pe "kubectl apply -f ./k8s-attach-manifest.yaml"
#echo

#pe "kubectl get ns"
#echo

#ATTACH TMC-REGISTRY-POLICY FROM UI PORTAL
#cluster_name="tmc-registry-policy"
#pe "kubectl config use-context arn:aws:eks:ap-northeast-1:964978768106:cluster/${cluster_name}"
#echo

#pe "kubectl get ns"
#echo

#read -p "YAML Configuration link: " yaml_config
#echo

#pe "kubectl apply -f ${yaml_config}"
#echo

#pe "kubectl get ns"
#echo







#SHOW VMWARE-SYSTEM-TMC
#pe "kubectl get ns"
#echo
#wait
#clear

#pe "tmc cluster namespace create -f tmc/namespace-spring-web-dev.yaml"
#echo

#pe "tmc cluster namespace create -f tmc/namespace-spring-app-dev.yaml"
#echo

#pe "tmc cluster namespace create -f tmc/namespace-spring-data-dev.yaml"
#echo

#pe "kubectl get ns"
#echo
#wait
#clear


#pe "cat tmc/registry-policy.yaml"
#echo

#pe "kubectl config current-context"
#echo


#RUN NGINX
#pe "kubectl run nginx-web --image nginx -n spring-web"
#echo

#pe "kubectl get pods -n spring-web"
#echo

#pe "kubectl delete pod nginx-web -n spring-web"
#echo
#wait
#clear


#QUOTA POLICY
#pe "kubectl config use-context tanzu-cluster-nginx-dev-eu-west-1-admin@tanzu-cluster-nginx-dev-eu-west-1"
#echo

#pe "cat tmc/quota-development-policy.yaml"
#echo

#pe "tmc clustergroup namespace-quota-policy create -f tmc/quota-development-policy.yaml" # -i --dry-run
#echo
#wait
#clear

#pe "cat deploy/deployment-spring-music-quota.yaml"
#echo

#pe "kubectl apply -f deploy/deployment-spring-music-quota.yaml"
#echo

#pe "kubectl get events"
#echo

#pe "kubectl get pods"
#echo
#wait
#clear


#DEMO_PROMPT="${GREEN}➜ TOS ${CYAN}\W "

#pe "helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update"
#echo

#pe "kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=f56e75ef-5ca0-41f8-ab2a-1693f55714ed --set clusterName="tanzu-cluster-nginx-dev-eu-west-1" --namespace wavefront"
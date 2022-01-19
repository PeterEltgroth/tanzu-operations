read -p "Azure Subscription: " subscription

access_cluster_group=eks-access-cluster-group
quota_cluster_group=eks-quota-cluster-group
custom_cluster_group=eks-custom-cluster-group
security_cluster_group=gke-security-cluster-group
registry_and_network_cluster=aks-registry-and-network-cluster

cluster_group=default-cluster-group
workspace_group=default-workspace-group
registry_workspace=registry-workspace
network_workspace=network-workspace

TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login

#CREATE CLUSTER GROUPS
read -p "Create cluster groups"
tmc clustergroup create --name $cluster_group --description "Demonstrates the cluster-only policies; security, quota, and custom."
tmc clustergroup create --name $workspace_group --description "Demonstrates the workspace-only policies; image registry and network."


#CREATE EKS ACCESS CLUSTER
read -p "Attach EKS Access Cluster"
kubectl config use-context $access_cluster_group

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $access_cluster_group --cluster-group $cluster_group
kubectl apply -f ./k8s-attach-manifest.yaml


#CREATE EKS QUOTA CLUSTER
read -p "Attach EKS Quota Cluster"
kubectl config use-context $quota_cluster_group

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $quota_cluster_group --cluster-group $cluster_group
kubectl apply -f ./k8s-attach-manifest.yaml


#CREATE EKS CUSTOM CLUSTER
read -p "Attach EKS Custom Cluster"
kubectl config use-context $custom_cluster_group

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $custom_cluster_group --cluster-group $cluster_group
kubectl apply -f ./k8s-attach-manifest.yaml


#CREATE SECURITY CLUSTER
read -p "Attach GKE Security Cluster"
kubectl config use-context $security_cluster_group

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $security_cluster_group --cluster-group $cluster_group
kubectl apply -f ./k8s-attach-manifest.yaml


#CREATE REGISTRY AND NETWORK CLUSTER
read -p "Attach AKS Registry/Network Cluster"
kubectl config use-context $registry_and_network_cluster

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $registry_and_network_cluster --cluster-group $workspace_group
kubectl apply -f ./k8s-attach-manifest.yaml


#CREATE WORKSPACES
tmc workspace create --name $registry_workspace --description "Demonstrates an image registry policy applicable to all namespaces therein."
tmc workspace create --name $network_workspace --description "Demonstrates a network policy between two pods from any image registry."

#CREATE NAMESPACES
tmc cluster namespace create -f configs/registry-namespace.yaml
tmc cluster namespace create -f configs/network-namespace.yaml

#CREATE REGISTRY & NETWORK POLICY
tmc workspace image-policy create -f configs/registry-policy.yaml
tmc workspace network-policy create -f configs/network-policy.yaml

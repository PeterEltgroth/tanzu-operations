read -p "Azure Subscription: " subscription

access_cluster_group=access-cluster-group
quota_cluster_group=quota-cluster-group
custom_cluster_group=custom-cluster-group

cluster_group=cluster-group
workspace_group=workspace-group
registry_workspace=registry-workspace
network_workspace=network-workspace

TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login
echo

#CREATE CLUSTER GROUPS
read -p "Create cluster groups"
echo

tmc clustergroup create --name $cluster_group --description "Demonstrates the cluster-only policies; security, quota, and custom."
tmc clustergroup create --name $workspace_group --description "Demonstrates the workspace-only policies; image registry and network."
echo


#CREATE EKS ACCESS CLUSTER
read -p "Attach EKS Access Cluster"
echo

kubectl config use-context $access_cluster_group
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $access_cluster_group --cluster-group $cluster_group
kubectl apply -f ./k8s-attach-manifest.yaml
echo

#CREATE EKS QUOTA CLUSTER
read -p "Attach EKS Quota Cluster"
echo

kubectl config use-context $quota_cluster_group
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $quota_cluster_group --cluster-group $cluster_group
kubectl apply -f ./k8s-attach-manifest.yaml
echo


#CREATE EKS CUSTOM CLUSTER
read -p "Attach EKS Custom Cluster"
echo

kubectl config use-context $custom_cluster_group
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $custom_cluster_group --cluster-group $cluster_group
kubectl apply -f ./k8s-attach-manifest.yaml
echo

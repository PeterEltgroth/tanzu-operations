read -p "Azure Subscription: " subscription

TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login
echo

access_cluster_group=eks-access-cluster-group
quota_cluster_group=eks-quota-cluster-group
custom_cluster_group=eks-custom-cluster-group
security_cluster_group=gke-security-cluster-group
registry_and_network_cluster=aks-registry-and-network-cluster

cluster_group=default-cluster-group
workspace_group=default-workspace-group
registry_workspace=registry-workspace
network_workspace=network-workspace

#DELETE POLICIES
#tmc workspace image-policy delete registry-policy --workspace-name registry-workspace
#tmc workspace network-policy delete network-policy --workspace-name network-workspace

#DELETE NAMESPACES
#tmc cluster namespace delete registry --cluster-name tmc-registry-and-network-cluster --management-cluster-name attached --provisioner-name attached
#tmc cluster namespace delete network --cluster-name tmc-registry-and-network-cluster --management-cluster-name attached --provisioner-name attached

#DELETE WORKSPACES
#tmc workspace delete registry-workspace
#tmc workspace delete network-workspace

#DELETE CLUSTERS
tmc cluster delete $access_cluster_group --management-cluster-name attached --provisioner-name attached
tmc cluster delete $quota_cluster_group --management-cluster-name attached --provisioner-name attached
tmc cluster delete $custom_cluster_group --management-cluster-name attached --provisioner-name attached
#tmc cluster delete $security_cluster_group --management-cluster-name attached --provisioner-name attached
#tmc cluster delete $registry_and_network_cluster --management-cluster-name attached --provisioner-name attached

read -p "Enter to continue"

#DELETE CLUSTER GROUPS
tmc clustergroup delete $cluster_group
tmc clustergroup delete $workspace_group

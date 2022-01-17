read -p "Azure Subscription: " subscription

TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login

#DELETE POLICIES
tmc workspace image-policy delete registry-policy --workspace-name registry-workspace
tmc workspace network-policy delete network-policy --workspace-name network-workspace

#DELETE NAMESPACES
tmc cluster namespace delete registry --cluster-name tmc-registry-and-network-cluster --management-cluster-name attached --provisioner-name attached
tmc cluster namespace delete network --cluster-name tmc-registry-and-network-cluster --management-cluster-name attached --provisioner-name attached

#DELETE WORKSPACES
tmc workspace delete registry-workspace
tmc workspace delete network-workspace

#DELETE CLUSTERS
tmc cluster delete tmc-registry-and-network-cluster --management-cluster-name attached --provisioner-name attached

#DELETE CLUSTER GROUPS
tmc clustergroup delete default-workspace-group

registry_and_network_cluster=tmc-registry-and-network-cluster

#TMC-REGISTRY-AND-NETWORK-WORKSPACE-CLUSTER
az aks create --name $registry_and_network_cluster --resource-group tanzu-operations --node-count 3 \
	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys
	
az aks get-credentials --name $registry_and_network_cluster --resource-group tanzu-mission-control

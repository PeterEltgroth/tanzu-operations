security_cluster_group=security-cluster-group

#TMC-REGISTRY-AND-NETWORK-WORKSPACE-CLUSTER
az aks create --name $security_cluster_group --resource-group tanzu-mission-control --node-count 1 \
	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys
	
az aks get-credentials --name $security_cluster_group --resource-group tanzu-mission-control

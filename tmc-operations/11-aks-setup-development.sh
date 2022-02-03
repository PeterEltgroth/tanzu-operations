cluster_name=tmc-development-cluster

az aks create --name $cluster_name --resource-group tanzu-mission-control --node-count 1 \
	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys
	
az aks get-credentials --name $cluster_name --resource-group tanzu-mission-control
cluster_name=tmc-development-cluster

#az aks create --name $cluster_name --resource-group tanzu-mission-control --node-count 1 --node-vm-size Standard_D8_v3 \
#	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys

#az aks get-credentials --name $cluster_name --resource-group tanzu-mission-control

az aks create --name $cluster_name --resource-group tanzu-service-mesh --node-count 3 --node-vm-size Standard_D2s_v3 \
	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys
	
az aks get-credentials --name $cluster_name --resource-group tanzu-service-mesh
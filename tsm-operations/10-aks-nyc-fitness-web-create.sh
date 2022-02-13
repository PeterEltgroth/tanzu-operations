cluster_name=nyc-fitness-web

az aks create --name $cluster_name --resource-group tanzu-service-mesh --node-count 3 \
	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys
	
az aks get-credentials --name $cluster_name --resource-group tanzu-service-mesh
tmc_staging_cluster=tmc-staging-cluster

az aks create --name $tmc_staging_cluster --resource-group tanzu-mission-control --node-count 1 \
	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys
	
az aks get-credentials --name $tmc_staging_cluster --resource-group tanzu-mission-control
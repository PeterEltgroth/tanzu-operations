tmc_security_cluster=tmc-security-cluster
tmc_quota_cluster_aks=tmc-quota-cluster-aks

#TMC-SECURITY-CLUSTER
az aks create --name $tmc_security_cluster --resource-group tanzu-mission-control --node-count 1 \
	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys
	
az aks get-credentials --name $tmc_security_cluster --resource-group tanzu-mission-control


#TMC-QUOTA-CLUSTER
az aks create --name $tmc_quota_cluster_aks --resource-group tanzu-mission-control --node-count 1 \
	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys
	
az aks get-credentials --name $tmc_quota_cluster_aks --resource-group tanzu-mission-control
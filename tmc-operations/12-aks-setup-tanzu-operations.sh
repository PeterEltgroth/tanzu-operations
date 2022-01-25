tmc_security_cluster=tmc-security-cluster

#TMC-REGISTRY-AND-NETWORK-WORKSPACE-CLUSTER
az aks create --name $tmc_security_cluster --resource-group tanzu-mission-control --node-count 1 \
	--enable-addons monitoring --network-plugin kubenet --network-policy calico --generate-ssh-keys
	
az aks get-credentials --name $tmc_security_cluster --resource-group tanzu-mission-control

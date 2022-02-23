read -p "Azure Subscription: " subscription
read -p "Cluster Name: " cluster_name

cluster_name=${cluster_name}-admin@${cluster_name}

pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
tbs_registry_secret=$(az keyvault secret show --name tanzu-build-service-registry --subscription $subscription --vault-name tanzuvault --query value --output tsv)

kubectl config use-context $cluster_name

docker logout registry.tanzu.vmware.com
docker logout tanzubuildservice.azurecr.io

docker login registry.tanzu.vmware.com -u mjames@pivotal.io -p ${pivnet_password}
docker login tanzubuildservice.azurecr.io -u tanzubuildservice -p ${tbs_registry_secret}

imgpkg copy -b "registry.tanzu.vmware.com/build-service/bundle:1.4.2" --to-repo tanzubuildservice.azurecr.io/build-service

#INSTALL TBS
imgpkg pull -b "tanzubuildservice.azurecr.io/build-service:1.4.2" -o /tmp/bundle

ytt -f /tmp/bundle/config/ \
	-v kp_default_repository="tanzubuildservice.azurecr.io/build-service" \
	-v kp_default_repository_username="tanzubuildservice" \
	-v kp_default_repository_password="${tbs_registry_secret}" \
	--data-value-yaml pull_from_kp_default_repo=true \
	-v tanzunet_username="mjames@pivotal.io" \
	-v tanzunet_password="${pivnet_password}" \
	-v descriptor_name="lite" \
	--data-value-yaml enable_automatic_dependency_updates=true \
	| kbld -f /tmp/bundle/.imgpkg/images.yml -f- \
	| kapp deploy -a tanzu-build-service -f- -y
	
kubectl get TanzuNetDependencyUpdater dependency-updater -n build-service -o yaml

kubectl get TanzuNetDependencyUpdaters -A

#VERIFY INSTALL
kp clusterbuilder list



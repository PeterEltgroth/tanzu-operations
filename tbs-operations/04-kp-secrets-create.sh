read -p "Azure Subscription: " subscription
read -p "Cluster Name: " cluster_name

cluster_name=${cluster_name}-admin@${cluster_name}

pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
tbs_registry_secret=$(az keyvault secret show --name tanzu-build-service-registry --subscription $subscription --vault-name tanzuvault --query value --output tsv)

kubectl config use-context $cluster_name

export REGISTRY_PASSWORD=$tbs_registry_secret
kp secret create tbs-registry-secret --registry tanzubuildservice.azurecr.io --registry-user tanzubuildservice


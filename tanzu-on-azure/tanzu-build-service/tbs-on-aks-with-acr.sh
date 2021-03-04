echo "INSTALLING AZURE CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

read -p "Azure Username: " az_username
read -p "Azure Password: " az_password
read -p "Azure Subscription: " subscription
read -p "Azure Resource Group: " group
read -p "AKS Cluster Name (tanzu-build-service): " cluster
read -p "ACR Registry Name (tanzuregistry): " registry

az login -u $az_username -p $az_password
az account set --subscription $subscription

az acr create --name $registry --resource-group $group --sku Basic
az acr update --name $registry --admin-enabled true

az aks create --name $cluster --resource-group $group --node-count 1 \
	--attach-acr $registry --enable-addons monitoring \
	--network-plugin kubenet --network-policy calico \
	--generate-ssh-keys

az aks get-credentials --name $cluster --resource-group $group

kubectl config use-context $cluster

read -p "Pivotal Username: " pivot_user
read -p "Pivotal Password: " pivot_pass
#read -p "ACR Admin Name: " acr_admin
#read -p "ACR Password: " acr_pass
read -p "ACR Repository Name (tbsimages): " repository

acr_admin=$(az acr credential show --name $registry --query username --output tsv)
acr_pass=$(az acr credential show --name $registry --query passwords[0].value --output tsv)

sudo docker login registry.pivotal.io -u $pivot_user -p $pivot_pass
sudo docker login ${registry}.azurecr.io -u $acr_admin -p $acr_pass

sudo kbld relocate -f /tmp/images.lock --lock-output /tmp/images-relocated.lock --repository ${registry}.azurecr.io/$repository

ytt -f /tmp/values.yaml \
    -f /tmp/manifests/ \
    -v docker_repository=${registry}.azurecr.io/${repository} \
    -v docker_username=$acr_admin \
    -v docker_password=$acr_pass \
    | sudo kbld -f /tmp/images-relocated.lock -f- \
    | kapp deploy -a tanzu-build-service -f- -y

sudo kp import -f descriptor-100.0.45.yaml

kp clusterbuilder list

kp secret create tanzuregistry-secret --registry ${registry}.azurecr.io --registry-user $acr_admin

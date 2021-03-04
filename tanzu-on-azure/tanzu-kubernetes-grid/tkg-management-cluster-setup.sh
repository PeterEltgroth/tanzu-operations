#az ad sp create-for-rbac --name tanzu-azure-sp --role Owner

#az ad sp credential reset --name tanzu-azure-sp

#ssh-keygen -t rsa -b 4096 -C "mijames@vmware.com"
#eval $(ssh-agent -s)
#ssh-add ~/.ssh/sp_rsa

read -p "Azure Username: " az_username
read -p "Azure Password: " az_password
read -p "Azure Subscription: " subscription
read -p "Resource Group: " group

az login -u $az_username -p $az_password
az account set --subscription $subscription

az vm image terms accept --publisher vmware-inc --offer tkg-capi --plan k8s-1dot19dot1-ubuntu-1804

tenant_id=$(az account show --query tenantId --output tsv)
subscription_id=$(az account show --query id --output tsv)
app_id=$( az ad sp list --show-mine --query "[?appDisplayName=='tanzu-azure-sp'].{appId:appId}" --output tsv)
client_key=$(az keyvault secret show --id https://tanzuvault.vault.azure.net/secrets/tanzu-azure-sp-secret/5e61728936d6412ebb04a5f27f7669ce --query value --output tsv)
public_key_encoded=$(openssl enc -base64 -in /home/mjames/.ssh/sp_rsa.pub -A)

rm .tkg/config.yaml
tkg get management-cluster

echo AZURE_TENANT_ID: $tenant_id >> .tkg/config.yaml
echo AZURE_SUBSCRIPTION_ID: $subscription_id >> .tkg/config.yaml
echo AZURE_LOCATION: eastus >> .tkg/config.yaml
echo AZURE_RESOURCE_GROUP: $group >> .tkg/config.yaml
echo AZURE_NODE_MACHINE_TYPE: Standard_D2s_v3 >> .tkg/config.yaml
echo MACHINE_HEALTH_CHECK_ENABLED: "true" >> .tkg/config.yaml
echo AZURE_CONTROL_PLANE_MACHINE_TYPE: Standard_D2s_v3 >> .tkg/config.yaml
echo AZURE_CLIENT_ID: $app_id >> .tkg/config.yaml
echo AZURE_CLIENT_SECRET: $client_key >> .tkg/config.yaml
echo AZURE_SSH_PUBLIC_KEY_B64: $public_key_encoded >> .tkg/config.yaml
echo SERVICE_CIDR: 100.64.0.0/13 >> .tkg/config.yaml
echo CLUSTER_CIDR: 100.96.0.0/11 >> .tkg/config.yaml
echo AZURE_VNET_NAME: tanzu-azure-management-cluster-vnet >> .tkg/config.yaml
#export AZURE_VNET_CIDR: 10.10.0.0/16
#export AZURE_CONTROL_PLANE_SUBNET_NAME: default
#export AZURE_CONTROL_PLANE_SUBNET_CIDR: 10.10.0.0/24
#export AZURE_NODE_SUBNET_NAME: default
#export AZURE_NODE_SUBNET_CIDR: 10.10.0.0/24

sudo tkg init --name tanzu-azure-management-cluster --infrastructure azure --plan dev

#kubectl logs deployment.apps/capz-controller-manager -n capz-system manager --kubeconfig ~/.kube-tkg/tmp/

#wget https://tanzustorage.blob.core.windows.net/tkg/velero-v1.5.2-linux-amd64.tar.gz
#gzip -d velero-v1.5.2-linux-amd64.tar.gz
#tar -xvf velero-v1.5.2-linux-amd64.tar

#sudo mv velero-v1.5.2-linux-amd64/velero /usr/local/bin/velero

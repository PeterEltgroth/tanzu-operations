read -p "Azure Subscription: " subscription
read -p "Pivotal Username (mjames@pivotal.io): " pivot_username
read -p "Pivotal Password: " pivot_password
read -p "AWS Region Code: " aws_region_code
read -p "EKS Cluster Name: " eks_cluster_name
read -p "Azure Container Registry (without domain): " az_registry
read -p "Azure Container Registry Password: " az_registry_password

#HELM
sudo snap install helm --classic

#JQ
sudo snap install jq

#AWS CLI, CLUSTERAWSADM
sudo apt install unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

#AZURE
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

az login
az account set --subscription $subscription

#KUBECTL
wget https://tanzustorage.blob.core.windows.net/tanzu/kubectl-linux-v1.21.2+vmware.1.gz
gzip -d kubectl-linux-v1.21.2+vmware.1.gz

sudo install kubectl-linux-v1.21.2+vmware.1 /usr/local/bin/kubectl
rm kubectl-linux-v1.21.2+vmware.1
kubectl version

mkdir .kube
touch .kube/config

aws configure
aws eks --region $aws_region_code update-kubeconfig --name $eks_cluster_name

kubectl config get-contexts
wait

read -p "Target Context: " target_context

kubectl config use-context $target_context

refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication

#TANZU CLUSTER ESSENTIALS
mkdir $HOME/tanzu-cluster-essentials
wget https://network.tanzu.vmware.com/api/v2/products/tanzu-cluster-essentials/releases/1011100/product_files/1105818/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz
tar -xvf $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz -C $HOME/tanzu-cluster-essentials
#rm $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz

export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=$pivot_username
export INSTALL_REGISTRY_PASSWORD=$pivot_password
cd $HOME/tanzu-cluster-essentials
./install.sh

sudo cp $HOME/tanzu-cluster-essentials/kapp /usr/local/bin/kapp

cd $HOME


#TANZU CLI
mkdir $HOME/tanzu
cd $HOME/tanzu
wget https://network.tanzu.vmware.com/api/v2/products/tanzu-application-platform/releases/1013926/product_files/1100110/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu/tanzu-framework-linux-amd64.tar
tar -xvf $HOME/tanzu/tanzu-framework-linux-amd64.tar -C $HOME/tanzu

sudo install cli/core/v0.12.0/tanzu-core-linux_amd64 /usr/local/bin/tanzu

#PLUGINS
tanzu config set features.global.context-aware-cli-for-plugins false
tanzu plugin install --local cli all
tanzu plugin list
wait

cd $HOME

#DEMO-MAGIC
wget https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh
sudo mv demo-magic.sh /usr/local/bin/demo-magic.sh
chmod +x /usr/local/bin/demo-magic.sh

sudo apt install pv #required for demo-magic
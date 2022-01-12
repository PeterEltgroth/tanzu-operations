#https://docs.vmware.com/en/Tanzu-Application-Platform/1.0/tap/GUID-install-general.html

read -p "Azure Subscription: " subscription
read -p "Azure Container Registry (without domain): " az_registry
read -p "Azure Container Registry Password: " az_registry_password

#KUBECTL
wget https://tanzustorage.blob.core.windows.net/tanzu/kubectl-linux-v1.21.2+vmware.1.gz
gzip -d kubectl-linux-v1.21.2+vmware.1.gz

sudo install kubectl-linux-v1.21.2+vmware.1 /usr/local/bin/kubectl
rm kubectl-linux-v1.21.2+vmware.1
kubectl version

mkdir .kube
touch .kube/config

kubectl config get-contexts
wait

read -p "Target Context: " target_context

kubectl config use-context $target_context

refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication

#INSTALL CLUSTER ESSENTIALS FOR VMWARE TANZU
mkdir $HOME/tanzu-cluster-essentials
wget https://network.tanzu.vmware.com/api/v2/products/tanzu-cluster-essentials/releases/1011100/product_files/1105818/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz
tar -xvf $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz -C $HOME/tanzu-cluster-essentials


pivot_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=mjames@pivotal.io
export INSTALL_REGISTRY_PASSWORD=$pivot_password
cd $HOME/tanzu-cluster-essentials
./install.sh

sudo cp $HOME/tanzu-cluster-essentials/kapp /usr/local/bin/kapp

cd $HOME


#INSTALL THE TANZU CLI AND PLUG-INS
mkdir $HOME/tanzu
cd $HOME/tanzu
wget https://network.pivotal.io/api/v2/products/tanzu-application-platform/releases/1030465/product_files/1114447/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu/tanzu-framework-linux-amd64.tar
tar -xvf $HOME/tanzu/tanzu-framework-linux-amd64.tar -C $HOME/tanzu

sudo install cli/core/v0.10.0/tanzu-core-linux_amd64 /usr/local/bin/tanzu

tanzu version
read -p "Confirm Tanzu Version"


#PLUGINS
export TANZU_CLI_NO_INIT=true
#tanzu config set features.global.context-aware-cli-for-plugins false
tanzu plugin install --local cli all
tanzu plugin list


cd $HOME

#DEMO-MAGIC
wget https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh
sudo mv demo-magic.sh /usr/local/bin/demo-magic.sh
chmod +x /usr/local/bin/demo-magic.sh

sudo apt install pv #required for demo-magic

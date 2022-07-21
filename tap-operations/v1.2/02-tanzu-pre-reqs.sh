kubectl config get-contexts

read -p "Select context: " kube_context

kubectl config use-context $kube_context

#CREDS
pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription nycpivot --vault-name tanzuvault --query value --output tsv)
refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription nycpivot --vault-name tanzuvault --query value --output tsv)
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication

#INSTALL TANZU FRAMEWORK BUNDLE
mkdir $HOME/tanzu
cd tanzu

wget https://network.pivotal.io/api/v2/products/tanzu-application-platform/releases/1127796/product_files/1246421/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu/tanzu-framework-linux-amd64-v0.11.6.tar

export TANZU_CLI_NO_INIT=true
export VERSION=v0.11.6

sudo install cli/core/$VERSION/tanzu-core-linux_amd64 /usr/local/bin/tanzu

tanzu version
sleep 5

tanzu plugin install --local cli all
tanzu plugin list





#INSTALL CLUSTER ESSENTIALS FOR VMWARE TANZU
mkdir $HOME/tanzu-cluster-essentials
wget https://network.tanzu.vmware.com/api/v2/products/tanzu-cluster-essentials/releases/1011100/product_files/1105818/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz
tar -xvf $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz -C $HOME/tanzu-cluster-essentials


export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=mjames@pivotal.io
export INSTALL_REGISTRY_PASSWORD=$pivnet_password
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


#PLUGINS
export TANZU_CLI_NO_INIT=true
#tanzu config set features.global.context-aware-cli-for-plugins false
tanzu plugin install --local cli all
tanzu plugin list

cd $HOME


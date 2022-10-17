#!/bin/bash

pivnet_user=mjames@pivotal.io

kubectl config get-contexts

read -p "Select context: " kube_context

kubectl config use-context $kube_context

#CREDS
pivnet_pass=$(az keyvault secret show --name pivnet-registry-secret --subscription nycpivot --vault-name tanzuvault --query value --output tsv)
refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription nycpivot --vault-name tanzuvault --query value --output tsv)
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication


#INSTALL TANZU FRAMEWORK BUNDLE
mkdir $HOME/tanzu

rm $HOME/tanzu/tanzu-framework-linux-amd64-v0.25.0.tar
wget https://network.tanzu.vmware.com/api/v2/products/tanzu-application-platform/releases/1182301/product_files/1310085/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu/tanzu-framework-linux-amd64-v0.25.0.tar
tar -xvf $HOME/tanzu/tanzu-framework-linux-amd64-v0.25.0.tar -C $HOME/tanzu

export TANZU_CLI_NO_INIT=true
export VERSION=v0.25.0
cd tanzu

sudo install cli/core/$VERSION/tanzu-core-linux_amd64 /usr/local/bin/tanzu

tanzu version
sleep 5

tanzu plugin install --local cli all
tanzu plugin list

cd $HOME


#CLUSTER ESSENTIALS
mkdir $HOME/tanzu-cluster-essentials

rm $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.3.0.tgz
wget https://network.tanzu.vmware.com/api/v2/products/tanzu-cluster-essentials/releases/1180593/product_files/1330470/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.3.0.tgz

tar -xvf $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.3.0.tgz -C $HOME/tanzu-cluster-essentials

export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:54bf611711923dccd7c7f10603c846782b90644d48f1cb570b43a082d18e23b9
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=$pivnet_user
export INSTALL_REGISTRY_PASSWORD=$pivnet_pass
cd $HOME/tanzu-cluster-essentials

./install.sh --yes

sudo cp $HOME/tanzu-cluster-essentials/kapp /usr/local/bin/kapp
sudo cp $HOME/tanzu-cluster-essentials/imgpkg /usr/local/bin/imgpkg

cd $HOME

docker login registry.tanzu.vmware.com -u $pivnet_user -p $pivnet_pass

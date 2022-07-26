pivnet_user=mjames@pivotal.io

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

wget https://network.pivotal.io/api/v2/products/tanzu-application-platform/releases/1127796/product_files/1246421/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu/tanzu-framework-linux-amd64-v0.11.6.tar
tar -xvf $HOME/tanzu/tanzu-framework-linux-amd64-v0.11.6.tar -C $HOME/tanzu

export TANZU_CLI_NO_INIT=true
export VERSION=v0.11.6
cd tanzu

sudo install cli/core/$VERSION/tanzu-core-linux_amd64 /usr/local/bin/tanzu

tanzu version
sleep 5

tanzu plugin install --local cli all
tanzu plugin list

cd $HOME


#CLUSTER ESSENTIALS
mkdir $HOME/tanzu-cluster-essentials

wget https://network.tanzu.vmware.com/api/v2/products/tanzu-cluster-essentials/releases/1130414/product_files/1263760/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.2.0.tgz
tar -xvf $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.2.0.tgz -C $HOME/tanzu-cluster-essentials

export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:e00f33b92d418f49b1af79f42cb13d6765f1c8c731f4528dfff8343af042dc3e
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=$pivnet_user
export INSTALL_REGISTRY_PASSWORD=$pivnet_pass
cd $HOME/tanzu-cluster-essentials

./install.sh --yes

sudo cp $HOME/tanzu-cluster-essentials/kapp /usr/local/bin/kapp
sudo cp $HOME/tanzu-cluster-essentials/imgpkg /usr/local/bin/imgpkg

cd $HOME

docker login registry.tanzu.vmware.com -u $pivnet_username -p $pivnet_password

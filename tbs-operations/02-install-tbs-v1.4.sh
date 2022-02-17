read -p "Azure Subscription: " subscription

#CREDS
pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication


mkdir $HOME/tanzu-cluster-essentials
wget https://network.tanzu.vmware.com/api/v2/products/kapp/releases/1010353/product_files/1103926/download --header="Authorization: Bearer ${access_token}" -O $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz
tar -xvf $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz -C $HOME/tanzu-cluster-essentials










mkdir tanzu
cd tanzu

wget https://tanzustorage.blob.core.windows.net/tanzu/tanzu-cli-bundle-linux-amd64-v1.4.tar
tar -xvf tanzu-cli-bundle-linux-amd64-v1.4.tar
rm tanzu-cli-bundle-linux-amd64-v1.4.tar

sudo install cli/core/v1.4.0/tanzu-core-linux_amd64 /usr/local/bin/tanzu
tanzu version

tanzu plugin install --local cli all
tanzu plugin list


#CARVEL (YTT, KAPP, KBLD, IMGPKG)
gunzip cli/ytt-linux-amd64-v0.34.0+vmware.1.gz
chmod ugo+x cli/ytt-linux-amd64-v0.34.0+vmware.1
sudo mv cli/ytt-linux-amd64-v0.34.0+vmware.1 /usr/local/bin/ytt

gunzip cli/kapp-linux-amd64-v0.37.0+vmware.1.gz
chmod ugo+x cli/kapp-linux-amd64-v0.37.0+vmware.1
sudo mv cli/kapp-linux-amd64-v0.37.0+vmware.1 /usr/local/bin/kapp

gunzip cli/kbld-linux-amd64-v0.30.0+vmware.1.gz
chmod ugo+x cli/kbld-linux-amd64-v0.30.0+vmware.1
sudo mv cli/kbld-linux-amd64-v0.30.0+vmware.1 /usr/local/bin/kbld

gunzip cli/imgpkg-linux-amd64-v0.10.0+vmware.1.gz
chmod ugo+x cli/imgpkg-linux-amd64-v0.10.0+vmware.1
sudo mv cli/imgpkg-linux-amd64-v0.10.0+vmware.1 /usr/local/bin/imgpkg

cd $HOME

#VELERO
wget https://tanzustorage.blob.core.windows.net/tanzu/velero-linux-v1.6.2_vmware.1.gz
gzip -d velero-linux-v1.6.2_vmware.1.gz

sudo install velero-linux-v1.6.2_vmware.1 /usr/local/bin/velero
rm velero-linux-v1.6.2_vmware.1


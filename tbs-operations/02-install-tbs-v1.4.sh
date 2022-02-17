read -p "Azure Subscription: " subscription

#CREDS
pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication


mkdir $HOME/tanzu-cluster-essentials
wget https://network.tanzu.vmware.com/api/v2/products/kapp/releases/1010353/product_files/1103926/download --header="Authorization: Bearer ${access_token}"
#tar -xvf $HOME/tanzu-cluster-essentials/tanzu-cluster-essentials-linux-amd64-1.0.0.tgz -C $HOME/tanzu-cluster-essentials













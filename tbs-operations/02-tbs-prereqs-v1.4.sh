read -p "Azure Subscription: " subscription

#CREDS
pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication


#KAPP
wget https://network.tanzu.vmware.com/api/v2/products/kapp/releases/1010353/product_files/1103926/download --header="Authorization: Bearer ${access_token}" -O kapp
sudo mv kapp /usr/local/bin/kapp
chmod ugo+x /usr/local/bin/kapp


#YTT
wget https://network.tanzu.vmware.com/api/v2/products/ytt/releases/1040612/product_files/1144002/download --header="Authorization: Bearer ${access_token}" -O ytt
sudo mv ytt /usr/local/bin/ytt
chmod ugo+x /usr/local/bin/ytt


#KBLD
wget https://network.tanzu.vmware.com/api/v2/products/kbld/releases/1015461/product_files/1110257/download --header="Authorization: Bearer ${access_token}" -O kbld
sudo mv kbld /usr/local/bin/kbld
chmod ugo+x /usr/local/bin/kbld


#IMGPKG
wget https://network.tanzu.vmware.com/api/v2/products/imgpkg/releases/1015358/product_files/1110115/download --header="Authorization: Bearer ${access_token}" -O imgpkg
sudo mv imgpkg /usr/local/bin/imgpkg
chmod ugo+x /usr/local/bin/imgpkg


#KPACK
wget https://network.tanzu.vmware.com/api/v2/products/build-service/releases/1016653/product_files/1082452/download --header="Authorization: Bearer ${access_token}" -O kp
sudo mv kp /usr/local/bin/kp
chmod ugo+x /usr/local/bin/kp


#DESCRIPTOR
wget https://network.tanzu.vmware.com/api/v2/products/tbs-dependencies/releases/1048580/product_files/1153911/download --header="Authorization: Bearer ${access_token}" -O descriptor-100.0.262.yaml

echo
echo "***COPY KUBE CONFIG FROM TKG CLUSTER***"
echo
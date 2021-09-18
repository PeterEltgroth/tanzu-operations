read -p "Azure Subscription: " subscription

refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)


#TANZU
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication


#KP-LINUX, TBS, KAPP, YTT, KBLD, DESCRIPTOR..."
wget -O "kp-linux" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/build-service/releases/925788/product_files/1000629/download
#wget -O "build-service-1.0.3.tar" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/build-service/releases/768025/product_files/817468/download

wget -O "kapp-linux-amd64" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/kapp/releases/847349/product_files/903764/download
wget -O "ytt-linux-amd64" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/ytt/releases/921457/product_files/995069/download
wget -O "kbld-linux-amd64" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/kbld/releases/887791/product_files/949949/download
wget -O "imgpkg-linux-amd64" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/imgpkg/releases/934077/product_files/1010564/download
#wget -O "descriptor-100.0.150.yaml" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/tbs-dependencies/releases/943744/product_files/1022067/download

sudo mv kapp-linux-amd64 /usr/local/bin/kapp
chmod +x /usr/local/bin/kapp

sudo mv ytt-linux-amd64 /usr/local/bin/ytt
chmod +x /usr/local/bin/ytt

sudo mv kbld-linux-amd64 /usr/local/bin/kbld
chmod +x /usr/local/bin/kbld

sudo mv imgpkg-linux-amd64 /usr/local/bin/imgpkg
chmod +x /usr/local/bin/imgpkg

sudo mv kp-linux /usr/local/bin/kp
chmod +x /usr/local/bin/kp
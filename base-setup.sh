#DOCKER
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu

sudo systemctl enable docker
sudo systemctl start docker


#KUBERNETES
sudo snap install kubectl --classic
#curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
#sudo mv ./kubectl /usr/local/bin/kubectl
#chmod +x /usr/local/bin/kubectl


#HELM
sudo snap install helm --classic


#JQ
sudo snap install jq
#"yes" | sudo apt install jq


#AWS CLI, CLUSTERAWSADM
sudo apt install unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

wget https://tanzustorage.blob.core.windows.net/tkg-1-dot-2/clusterawsadm-linux-amd64-v0.5.4-vmware-1.gz
gunzip clusterawsadm-linux-amd64-v0.5.4-vmware-1.gz
sudo mv clusterawsadm-linux-amd64-v0.5.4-vmware-1 /usr/local/bin/clusterawsadm
chmod +x /usr/local/bin/clusterawsadm


#DO THIS LAST, IT'S A PAIN IN THE ASS
#GCLOUD CLI
sudo snap install google-cloud-sdk --classic

gcloud auth login
gcloud config set project pa-mjames
#curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-329.0.0-linux-x86_64.tar.gz
#tar xopf google-cloud-sdk-329.0.0-linux-x86_64.tar.gz
#rm google-cloud-sdk-329.0.0-linux-x86_64.tar.gz
#"N" | ./google-cloud-sdk/install.sh
#gcloud components update


#AZ CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

#read -p "Azure/VMware Username: " az_username
#read -p "Azure/VMware Password: " az_password
read -p "Azure Subscription: " subscription

az login # -u $az_username -p $az_password
az account set --subscription $subscription

refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)


#TANZU
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication


#KP-LINUX, TBS, KAPP, YTT, KBLD, DESCRIPTOR..."
wget -O "kp-linux" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/build-service/releases/768025/product_files/817470/download
wget -O "build-service-1.0.3.tar" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/build-service/releases/768025/product_files/817468/download

wget -O "kapp-linux-amd64" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/kapp/releases/737858/product_files/783709/download
wget -O "ytt-linux-amd64" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/ytt/releases/715787/product_files/759637/download
wget -O "kbld-linux-amd64" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/kbld/releases/767540/product_files/816940/download
wget -O "descriptor-100.0.60.yaml" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/tbs-dependencies/releases/813822/product_files/867688/download
wget -O "descriptor-100.0.65.yaml" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/tbs-dependencies/releases/829109/product_files/884725/download

sudo mv kapp-linux-amd64 /usr/local/bin/kapp
chmod +x /usr/local/bin/kapp

sudo mv ytt-linux-amd64 /usr/local/bin/ytt
chmod +x /usr/local/bin/ytt

sudo mv kbld-linux-amd64 /usr/local/bin/kbld
chmod +x /usr/local/bin/kbld

sudo mv kp-linux /usr/local/bin/kp
chmod +x /usr/local/bin/kp

tar xvf build-service-1.0.3.tar -C /tmp


#DOCKER
sudo usermod -aG docker $USER
#newgrp docker


#TKG
wget https://tanzustorage.blob.core.windows.net/tkg-1-dot-2/tkg-linux-amd64-v1.2.1-vmware.1.tar.gz
tar -xzvf tkg-linux-amd64-v1.2.1-vmware.1.tar.gz
rm tkg-linux-amd64-v1.2.1-vmware.1.tar.gz
sudo mv tkg/tkg-linux-amd64-v1.2.1+vmware.1 /usr/local/bin/tkg
chmod +x /usr/local/bin/tkg

tkg get management-cluster


#velero
wget https://tanzustorage.blob.core.windows.net/tkg-1-dot-2/velero-linux-v1.4.3_vmware.1.gz
#rm velero-linux-v1.4.3_vmware.1.gz

#DEMO-MAGIC
wget https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh
sudo mv demo-magic.sh /usr/local/bin/demo-magic.sh
chmod +x /usr/local/bin/demo-magic.sh

sudo apt install pv
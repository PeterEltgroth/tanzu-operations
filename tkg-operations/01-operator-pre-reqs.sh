subscription=nycpivot

sudo apt update
yes | sudo apt upgrade

#DOCKER
yes | sudo apt install docker.io
sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker $USER

#MISC TOOLS
sudo snap install jq
sudo snap install helm --classic
sudo apt install unzip

#AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

#AZURE
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login
az account set --subscription $subscription

#GCLOUD CLI
sudo snap install google-cloud-sdk --classic

gcloud auth login
gcloud config set project pa-mjames

#AWS
aws_access_key_id=$(az keyvault secret show --name aws-account-access-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)
aws_secret_access_key=$(az keyvault secret show --name aws-account-secret-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)

aws_region_code=us-east-2
export AWS_ACCESS_KEY_ID=$aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
export AWS_DEFAULT_REGION=$aws_region_code

aws configure


#KUBECTL
wget https://tanzustorage.blob.core.windows.net/tanzu/kubectl-linux-v1.21.2+vmware.1.gz
gzip -d kubectl-linux-v1.21.2+vmware.1.gz

sudo install kubectl-linux-v1.21.2+vmware.1 /usr/local/bin/kubectl
rm kubectl-linux-v1.21.2+vmware.1
kubectl version


#TANZU CLI
mkdir tanzu
cd tanzu

wget https://tanzustorage.blob.core.windows.net/tanzu/tanzu-cli-bundle-linux-amd64-v1.4.tar
tar -xvf tanzu-cli-bundle-linux-amd64-v1.4.tar
rm tanzu-cli-bundle-linux-amd64-v1.4.tar

sudo install cli/core/v1.4.0/tanzu-core-linux_amd64 /usr/local/bin/tanzu
tanzu version

tanzu plugin install --local cli all
tanzu plugin list

#VELERO
wget https://tanzustorage.blob.core.windows.net/tanzu/velero-linux-v1.6.2_vmware.1.gz
gzip -d velero-linux-v1.6.2_vmware.1.gz

sudo install velero-linux-v1.6.2_vmware.1 /usr/local/bin/velero
rm velero-linux-v1.6.2_vmware.1


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


#DEMO-MAGIC
wget https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh
sudo mv demo-magic.sh /usr/local/bin/demo-magic.sh
chmod +x /usr/local/bin/demo-magic.sh

sudo apt install pv #required for demo-magic

echo "***REBOOTING***"

sudo reboot

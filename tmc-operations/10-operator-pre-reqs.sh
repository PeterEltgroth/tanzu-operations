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

#KUBECTL
wget https://tanzustorage.blob.core.windows.net/tanzu/kubectl-linux-v1.21.2+vmware.1.gz
gzip -d kubectl-linux-v1.21.2+vmware.1.gz

sudo install kubectl-linux-v1.21.2+vmware.1 /usr/local/bin/kubectl
rm kubectl-linux-v1.21.2+vmware.1
kubectl version

#TMC CLI
wget https://tanzustorage.blob.core.windows.net/tanzu/tmc -O tmc-cli
sudo mv tmc-cli /usr/local/bin/tmc
chmod +x /usr/local/bin/tmc

aws_access_key_id=$(az keyvault secret show --name aws-account-access-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)
aws_secret_access_key=$(az keyvault secret show --name aws-account-secret-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)

aws_region_code=us-east-2
export AWS_ACCESS_KEY_ID=$aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
export AWS_DEFAULT_REGION=$aws_region_code

aws configure

#DEMO-MAGIC
wget https://raw.githubusercontent.com/paxtonhare/demo-magic/master/demo-magic.sh
sudo mv demo-magic.sh /usr/local/bin/demo-magic.sh
chmod +x /usr/local/bin/demo-magic.sh

sudo apt install pv #required for demo-magic

#STORE VOLUME ID FOR SNAPSHOT
aws s3 cp s3://tmc-operations/operator-instance.txt ./

ebs_volume_id=$(aws ec2 describe-instances --instance-ids $instance_id | jq '[.Reservations[].Instances[] | (.BlockDeviceMappings[] | { VolumeId: .Ebs.VolumeId })]')
volume_id=$(eval "echo \${ebs_volume_id} | jq '.[] | .VolumeId'" | tr -d '"')

aws s3 rm s3://tmc-operations/volume-id.txt --recursive
echo $volume_id | aws s3 cp - s3://tmc-operations/volume-id.txt

echo "***REBOOTING***"

sudo reboot

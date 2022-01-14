read -p "Azure Subscription: " subscription
read -p "AWS Region Code: " aws_region_code
read -p "EKS Cluster Name: " eks_cluster_name

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

#KUBECTL
wget https://tanzustorage.blob.core.windows.net/tanzu/kubectl-linux-v1.21.2+vmware.1.gz
gzip -d kubectl-linux-v1.21.2+vmware.1.gz

sudo install kubectl-linux-v1.21.2+vmware.1 /usr/local/bin/kubectl
rm kubectl-linux-v1.21.2+vmware.1
kubectl version

mkdir .kube
touch .kube/config

aws_access_key_id=$(az keyvault secret show --name aws-account-access-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)
aws_secret_access_key=$(az keyvault secret show --name aws-account-secret-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export AWS_ACCESS_KEY_ID=$aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
export AWS_DEFAULT_REGION=$aws_region_code

aws configure

aws eks create-cluster \
   --region $aws_region_code \
   --name $eks_cluster_name \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6
   
read -p "Press Enter to continue"

aws eks create-nodegroup \
	--cluster-name $eks_cluster_name \
	--nodegroup-name "${eks_cluster_name}-node-group" \
	--disk-size 500 \
	--scaling-config minSize=3,maxSize=3,desiredSize=3 \
	--subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
	--instance-types t3a.2xlarge \
	--node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
	--kubernetes-version 1.21

aws eks --region $aws_region_code update-kubeconfig --name $eks_cluster_name

echo "REBOOT TO START DOCKER SERVICE"

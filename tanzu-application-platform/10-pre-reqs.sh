read -p "Azure Subscription: " subscription
read -p "AWS Region Code: " aws_region_code
read -p "EKS Cluster Name: " eks_cluster_name

sudo apt update
yes | sudo apt upgrade

#MISC TOOLS
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

#CREDS
pivot_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
aws_access_key_id=$(az keyvault secret show --name aws-account-access-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)
aws_secret_access_key=$(az keyvault secret show --name aws-account-secret-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export AWS_ACCESS_KEY_ID=$aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
export AWS_DEFAULT_REGION=$aws_region_code
	
aws eks --region $aws_region_code update-kubeconfig --name $eks_cluster_name


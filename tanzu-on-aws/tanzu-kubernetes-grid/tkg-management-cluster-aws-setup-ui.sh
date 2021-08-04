read -p "Azure Username: " az_username
read -p "Azure Password: " az_password
read -p "Azure Subscription: " subscription

aws_access_key=$(az keyvault secret show --name aws-account-access-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)
aws_secret_key=$(az keyvault secret show --name aws-account-secret-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)

read -p "AWS Region, i.e., us-east-[1|2]: " aws_region
read -p "AWS AZ, i.e., us-east-1a: " aws_az
read -p "AWS Config Name, i.e., aws-us-east-1: " aws_config_name

#SET ENV VARIABLES
export AWS_ACCESS_KEY_ID=$aws_access_key
export AWS_SECRET_ACCESS_KEY=$aws_secret_key
export AWS_REGION=$aws_region

tanzu management-cluster create tanzu-management-cluster --ui --browser none

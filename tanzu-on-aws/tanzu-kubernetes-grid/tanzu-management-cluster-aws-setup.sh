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

aws ec2 delete-key-pair --key-name default
aws ec2 create-key-pair --key-name default --output json | jq .KeyMaterial -r > default.pem


#APPEND SETTINGS TO .TKG/CONFIG.YAML
echo AWS_ACCESS_KEY_ID: $aws_access_key >> .tkg/${aws_config_name}.yaml
echo AWS_SECRET_ACCESS_KEY: $aws_secret_key >> .tkg/${aws_config_name}.yaml
echo AWS_B64ENCODED_CREDENTIALS: $(printf "[default]\\n${AWS_REGION}\\n" | base64) >> .tkg/${aws_config_name}.yaml
echo AWS_REGION: $aws_region >> .tkg/${aws_config_name}.yaml
echo AWS_NODE_AZ: $aws_az >> .tkg/${aws_config_name}.yaml
echo AWS_VPC_CIDR: 10.0.0.0/16 >> .tkg/${aws_config_name}.yaml #can't be used if AWS_VPC_ID is set
echo AWS_PUBLIC_NODE_CIDR: 10.0.1.0/24 >> .tkg/${aws_config_name}.yaml
echo AWS_PRIVATE_NODE_CIDR: 10.0.0.0/24 >> .tkg/${aws_config_name}.yaml
echo AWS_SSH_KEY_NAME: default >> .tkg/${aws_config_name}.yaml
echo SERVICE_CIDR: 100.64.0.0/13 >> .tkg/${aws_config_name}.yaml
echo CLUSTER_CIDR: 100.96.0.0/11 >> .tkg/${aws_config_name}.yaml
echo CONTROL_PLANE_MACHINE_TYPE: t3.2xlarge >> .tkg/${aws_config_name}.yaml
echo NODE_MACHINE_TYPE: t3.2xlarge >> .tkg/${aws_config_name}.yaml

#CREATE CLOUD FORMATION STACK
tkg config permissions aws

echo "sudo tkg init --name tanzu-management-cluster-${aws_config_name} --infrastructure aws --plan dev --config .tkg/${aws_config_name}.yaml"

#kubectl logs deployment.apps/capa-controller-manager -n capa-system manager --kubeconfig ~/.kube-tkg/tmp/

#wget https://tanzustorage.blob.core.windows.net/tkg/velero-v1.5.2-linux-amd64.tar.gz
#gzip -d velero-v1.5.2-linux-amd64.tar.gz
#tar -xvf velero-v1.5.2-linux-amd64.tar

#sudo mv velero-v1.5.2-linux-amd64/velero /usr/local/bin/velero

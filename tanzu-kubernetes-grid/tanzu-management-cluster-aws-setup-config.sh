read -p "Azure Subscription: " subscription

aws_access_key=$(az keyvault secret show --name aws-account-access-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)
aws_secret_key=$(az keyvault secret show --name aws-account-secret-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)

read -p "AWS Region: " aws_region
read -p "AWS AZ: " aws_az
read -p "Tanzu Mgmt Cluster Name, i.e., aws-us-east-1: " mgmt_cluster_name
read -p "Cluster Plan (dev|prod): " plan
read -p "IdP Client Id: " client_id
read -p "IdP Client Secret: " client_secret
read -p "IdP Issuer Url: " issuer_url

client_secret=echo $client_secret | base64


#SET ENV VARIABLES
export AWS_ACCESS_KEY_ID=$aws_access_key
export AWS_SECRET_ACCESS_KEY=$aws_secret_key
export AWS_REGION=$aws_region
export AWS_SSH_KEY_NAME=$aws_ssh_key_name

aws ec2 delete-key-pair --key-name $aws_ssh_key_name
aws ec2 create-key-pair --key-name $aws_ssh_key_name --output json | jq .KeyMaterial -r > $aws_ssh_key_name.pem

mkdir .config
mkdir .config/tanzu
mkdir .config/tanzu/tkg
mkdir .config/tanzu/tkg/clusterconfigs


#APPEND SETTINGS TO .TKG/CONFIG.YAML
echo AWS_AMI_ID: ami-0f0f0bb6426dfbe79 >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_SSH_KEY_NAME: $aws_ssh_key_name >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_REGION: $aws_region >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_NODE_AZ: $aws_az >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_NODE_AZ_1: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_NODE_AZ_2: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_VPC_CIDR: 10.0.0.0/16 >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_VPC_ID: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PUBLIC_NODE_CIDR: 10.0.0.0/20 >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PUBLIC_NODE_CIDR_1: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PUBLIC_NODE_CIDR_2: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PUBLIC_SUBNET_ID: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PUBLIC_SUBNET_ID_1: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PUBLIC_SUBNET_ID_2: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PRIVATE_NODE_CIDR: 10.0.16.0/20 >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PRIVATE_NODE_CIDR_1: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PRIVATE_NODE_CIDR_2: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PRIVATE_SUBNET_ID: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PRIVATE_SUBNET_ID_1: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo AWS_PRIVATE_SUBNET_ID_2: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo SERVICE_CIDR: 100.64.0.0/13 >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo CLUSTER_CIDR: 100.96.0.0/11 >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo CLUSTER_NAME: $mgmt_cluster_name >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo CLUSTER_PLAN: $plan >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo BASTION_HOST_ENABLED: "true" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo NODE_MACHINE_TYPE: t3.2xlarge >> >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo CONTROL_PLANE_MACHINE_TYPE: t3.2xlarge >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo ENABLE_AUDIT_LOGGING: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo ENABLE_CEIP_PARTICIPATION: "false" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo ENABLE_MHC: "true" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo IDENTITY_MANAGEMENT_TYPE: oidc >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo INFRASTRUCTURE_PROVIDER: aws >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_BIND_DN: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_BIND_PASSWORD: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_GROUP_SEARCH_BASE_DN: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_GROUP_SEARCH_FILTER: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_GROUP_SEARCH_GROUP_ATTRIBUTE: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_GROUP_SEARCH_NAME_ATTRIBUTE: cn >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_GROUP_SEARCH_USER_ATTRIBUTE: DN >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_HOST: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_ROOT_CA_DATA_B64: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_USER_SEARCH_BASE_DN: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_USER_SEARCH_FILTER: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_USER_SEARCH_NAME_ATTRIBUTE: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo LDAP_USER_SEARCH_USERNAME: userPrincipalName >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OIDC_IDENTITY_PROVIDER_CLIENT_ID: $client_id >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OIDC_IDENTITY_PROVIDER_CLIENT_SECRET: $client_secret >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OIDC_IDENTITY_PROVIDER_GROUPS_CLAIM: groups >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OIDC_IDENTITY_PROVIDER_ISSUER_URL: issuer_url >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OIDC_IDENTITY_PROVIDER_NAME: "" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OIDC_IDENTITY_PROVIDER_SCOPES: email >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OIDC_IDENTITY_PROVIDER_USERNAME_CLAIM: email >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OS_ARCH: amd64 >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OS_NAME: ubuntu >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo OS_VERSION: "20.04" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
echo TKG_HTTP_PROXY_ENABLED: "false" >> .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml

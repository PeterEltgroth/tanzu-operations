read -p "Management Cluster Name: " mgmt_cluster_name
read -p "Workload Cluster Name: " workload_cluster_name
read -p "Bastion Host Enabled (true/false): " bastion_enabled
read -p "AWS Region Code (us-east-2): " aws_region_code

if [[ -z $bastion_enabled ]]
then
	bastion_enabled=false
fi

if [[ -z $aws_region_code ]]
then
	aws_region_code=us-east-2
fi

export AWS_REGION=${aws_region_code}

#GET SSH KEY
aws ec2 describe-key-pairs
read -p "Input Key Name: " ssh_key_name

#GET VPC ID
vpc_filters="Name=tag:Name,Values=${mgmt_cluster_name}-vpc"
vpc_id=$(aws ec2 describe-vpcs --filters $vpc_filters | jq '.Vpcs | .[] | { VpcId: .VpcId } | .VpcId' | tr -d '"')

#GET PUBLIC SUBNET ID
public_subnet_filters="Name=tag:Name,Values=${mgmt_cluster_name}-subnet-public-${aws_region_code}a"
public_subnet_id=$(aws ec2 describe-subnets --filters $public_subnet_filters | jq '.Subnets | .[] | { SubnetId: .SubnetId } | .SubnetId' | tr -d '"')

#GET PRIVATE SUBNET ID
private_subnet_filters="Name=tag:Name,Values=${mgmt_cluster_name}-subnet-private-${aws_region_code}a"
private_subnet_id=$(aws ec2 describe-subnets --filters $private_subnet_filters | jq '.Subnets | .[] | { SubnetId: .SubnetId } | .SubnetId' | tr -d '"')


rm .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml
cat <<EOF | tee .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml
AWS_AMI_ID: ami-0954a3d2fbcc97789
AWS_NODE_AZ: ${aws_region_code}a
AWS_NODE_AZ_1: ""
AWS_NODE_AZ_2: ""
AWS_PRIVATE_NODE_CIDR: 10.0.0.0/24
AWS_PRIVATE_NODE_CIDR_1: ""
AWS_PRIVATE_NODE_CIDR_2: ""
AWS_PRIVATE_SUBNET_ID: "${private_subnet_id}"
AWS_PRIVATE_SUBNET_ID_1: ""
AWS_PRIVATE_SUBNET_ID_2: ""
AWS_PUBLIC_NODE_CIDR: 10.0.1.0/24
AWS_PUBLIC_NODE_CIDR_1: ""
AWS_PUBLIC_NODE_CIDR_2: ""
AWS_PUBLIC_SUBNET_ID: "${public_subnet_id}"
AWS_PUBLIC_SUBNET_ID_1: ""
AWS_PUBLIC_SUBNET_ID_2: ""
AWS_REGION: ${aws_region_code}
AWS_SSH_KEY_NAME: ${ssh_key_name}
AWS_VPC_CIDR: 10.0.0.0/16
AWS_VPC_ID: "${vpc_id}"
BASTION_HOST_ENABLED: "${bastion_enabled}"
CLUSTER_CIDR: 100.96.0.0/11
CLUSTER_NAME: ${workload_cluster_name}
CLUSTER_PLAN: dev
CONTROL_PLANE_MACHINE_TYPE: t3.large
ENABLE_AUDIT_LOGGING: ""
ENABLE_CEIP_PARTICIPATION: "false"
ENABLE_MHC: "true"
IDENTITY_MANAGEMENT_TYPE: none
INFRASTRUCTURE_PROVIDER: aws
LDAP_BIND_DN: ""
LDAP_BIND_PASSWORD: ""
LDAP_GROUP_SEARCH_BASE_DN: ""
LDAP_GROUP_SEARCH_FILTER: ""
LDAP_GROUP_SEARCH_GROUP_ATTRIBUTE: ""
LDAP_GROUP_SEARCH_NAME_ATTRIBUTE: cn
LDAP_GROUP_SEARCH_USER_ATTRIBUTE: DN
LDAP_HOST: ""
LDAP_ROOT_CA_DATA_B64: ""
LDAP_USER_SEARCH_BASE_DN: ""
LDAP_USER_SEARCH_FILTER: ""
LDAP_USER_SEARCH_NAME_ATTRIBUTE: ""
LDAP_USER_SEARCH_USERNAME: userPrincipalName
NODE_MACHINE_TYPE: t3a.2xlarge
OIDC_IDENTITY_PROVIDER_CLIENT_ID: ""
OIDC_IDENTITY_PROVIDER_CLIENT_SECRET: ""
OIDC_IDENTITY_PROVIDER_GROUPS_CLAIM: ""
OIDC_IDENTITY_PROVIDER_ISSUER_URL: ""
OIDC_IDENTITY_PROVIDER_NAME: ""
OIDC_IDENTITY_PROVIDER_SCOPES: ""
OIDC_IDENTITY_PROVIDER_USERNAME_CLAIM: ""
OS_ARCH: amd64
OS_NAME: ubuntu
OS_VERSION: "20.04"
SERVICE_CIDR: 100.64.0.0/13
TKG_HTTP_PROXY_ENABLED: "false"
EOF

echo
tanzu login

tanzu cluster create $workload_cluster_name -f .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml --plan dev

rm ${workload_cluster_name}-kubeconfig.yaml

tanzu cluster kubeconfig get $workload_cluster_name --admin
tanzu cluster kubeconfig get $workload_cluster_name --admin --export-file ${workload_cluster_name}-kubeconfig.yaml

#TAG THE PUBLIC SUBNET TO BE ABLE TO CREATE ELBs
#aws ec2 delete-tags --resources YOUR-PUBLIC-SUBNET-ID-OR-IDS
aws ec2 create-tags --resources $public_subnet_id --tags Key=kubernetes.io/cluster/${workload_cluster_name},Value=shared

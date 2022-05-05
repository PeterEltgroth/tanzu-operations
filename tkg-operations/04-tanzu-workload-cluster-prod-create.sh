read -p "Management Cluster Name: " mgmt_cluster_name
read -p "Workload Cluster Name: " workload_cluster_name
read -p "Bastion Host Enabled (true/false): " bastion_enabled
read -p "AWS Region Code (us-east-2): " aws_region_code
read -p "Worker Machine Count: " worker_machine_count

if [[ -z $bastion_enabled ]]
then
	bastion_enabled=false
fi

if [[ -z $aws_region_code ]]
then
	aws_region_code=us-east-2
fi

suffix=$(echo $RANDOM | md5sum | head -c 20)
workload_cluster_name=${workload_cluster_name}-${suffix}

export AWS_REGION=${aws_region_code}

aws ec2 describe-key-pairs

read -p "Input Key Name: " ssh_key_name

vpc_filters="Name=tag:Name,Values=${mgmt_cluster_name}-vpc"
vpc_id=$(aws ec2 describe-vpcs --filters $vpc_filters | jq '.Vpcs | .[] | { VpcId: .VpcId } | .VpcId' | tr -d '"')

public_subnet_filters="Name=tag:Name,Values=${mgmt_cluster_name}-subnet-public-${aws_region_code}a"
public_subnet_id_a=$(aws ec2 describe-subnets --filters $public_subnet_filters | jq '.Subnets | .[] | { SubnetId: .SubnetId } | .SubnetId' | tr -d '"')

public_subnet_filters="Name=tag:Name,Values=${mgmt_cluster_name}-subnet-public-${aws_region_code}b"
public_subnet_id_b=$(aws ec2 describe-subnets --filters $public_subnet_filters | jq '.Subnets | .[] | { SubnetId: .SubnetId } | .SubnetId' | tr -d '"')

public_subnet_filters="Name=tag:Name,Values=${mgmt_cluster_name}-subnet-public-${aws_region_code}c"
public_subnet_id_c=$(aws ec2 describe-subnets --filters $public_subnet_filters | jq '.Subnets | .[] | { SubnetId: .SubnetId } | .SubnetId' | tr -d '"')

private_subnet_filters="Name=tag:Name,Values=${mgmt_cluster_name}-subnet-private-${aws_region_code}a"
private_subnet_id_a=$(aws ec2 describe-subnets --filters $private_subnet_filters | jq '.Subnets | .[] | { SubnetId: .SubnetId } | .SubnetId' | tr -d '"')

private_subnet_filters="Name=tag:Name,Values=${mgmt_cluster_name}-subnet-private-${aws_region_code}b"
private_subnet_id_b=$(aws ec2 describe-subnets --filters $private_subnet_filters | jq '.Subnets | .[] | { SubnetId: .SubnetId } | .SubnetId' | tr -d '"')

private_subnet_filters="Name=tag:Name,Values=${mgmt_cluster_name}-subnet-private-${aws_region_code}c"
private_subnet_id_c=$(aws ec2 describe-subnets --filters $private_subnet_filters | jq '.Subnets | .[] | { SubnetId: .SubnetId } | .SubnetId' | tr -d '"')


rm .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml
cat <<EOF | tee .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml
AWS_NODE_AZ: ${aws_region_code}a
AWS_NODE_AZ_1: ${aws_region_code}b
AWS_NODE_AZ_2: ${aws_region_code}c
AWS_PRIVATE_NODE_CIDR: 10.0.0.0/24
AWS_PRIVATE_NODE_CIDR_1: 10.0.2.0/24
AWS_PRIVATE_NODE_CIDR_2: 10.0.4.0/24
AWS_PRIVATE_SUBNET_ID: "${private_subnet_id_a}"
AWS_PRIVATE_SUBNET_ID_1: "${private_subnet_id_b}"
AWS_PRIVATE_SUBNET_ID_2: "${private_subnet_id_c}"
AWS_PUBLIC_NODE_CIDR: 10.0.1.0/24
AWS_PUBLIC_NODE_CIDR_1: 10.0.3.0/24
AWS_PUBLIC_NODE_CIDR_2: 10.0.5.0/24
AWS_PUBLIC_SUBNET_ID: "${public_subnet_id_a}"
AWS_PUBLIC_SUBNET_ID_1: "${public_subnet_id_b}"
AWS_PUBLIC_SUBNET_ID_2: "${public_subnet_id_c}"
AWS_REGION: ${aws_region_code}
AWS_SSH_KEY_NAME: ${ssh_key_name}
AWS_VPC_CIDR: 10.0.0.0/16
AWS_VPC_ID: "${vpc_id}"
BASTION_HOST_ENABLED: "${bastion_enabled}"
CLUSTER_CIDR: 100.96.0.0/11
CLUSTER_NAME: ${workload_cluster_name}
CLUSTER_PLAN: prod
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
WORKER_MACHINE_COUNT: $worker_machine_count
EOF

echo
tanzu login

tanzu cluster create $workload_cluster_name -f .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml --plan prod

rm ${workload_cluster_name}-kubeconfig.yaml

tanzu cluster kubeconfig get $workload_cluster_name --admin
tanzu cluster kubeconfig get $workload_cluster_name --admin --export-file ${workload_cluster_name}-kubeconfig.yaml

#TAG THE PUBLIC SUBNET TO BE ABLE TO CREATE ELBs
#aws ec2 delete-tags --resources YOUR-PUBLIC-SUBNET-ID-OR-IDS
aws ec2 create-tags --resources $public_subnet_id_a --tags Key=kubernetes.io/cluster/${workload_cluster_name},Value=shared
aws ec2 create-tags --resources $public_subnet_id_b --tags Key=kubernetes.io/cluster/${workload_cluster_name},Value=shared
aws ec2 create-tags --resources $public_subnet_id_c --tags Key=kubernetes.io/cluster/${workload_cluster_name},Value=shared

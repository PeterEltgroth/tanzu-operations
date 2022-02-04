read -p "AWS Region Code (us-east-2): " aws_region_code
read -p "Workload Cluster Name: " workload_cluster_name

aws ec2 describe-key-pairs

read -p "Input Key Name: " ssh_key_name

#aws ec2 describe-vpcs | jq "[.Vpcs[] | { VpcId }, (.Tags[]) | { Value }]" #.Instances[] | (.BlockDeviceMappings[] | { VolumeId: .Ebs.VolumeId })]'

aws ec2 describe-vpcs

read -p "VPC Id: " vpc_id

aws ec2 describe-subnets

read -p "Private Subnet Id: " private_subnet_id
read -p "Public Subnet Id: " public_subnet_id


rm .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml
cat <<EOF | tee .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml
AWS_AMI_ID: ami-08f4095e19c367152
AWS_NODE_AZ: ${aws_region_code}a
AWS_NODE_AZ_1: ""
AWS_NODE_AZ_2: ""
AWS_PRIVATE_NODE_CIDR: 10.0.16.0/20
AWS_PRIVATE_NODE_CIDR_1: ""
AWS_PRIVATE_NODE_CIDR_2: ""
AWS_PRIVATE_SUBNET_ID: "${private_subnet_id}"
AWS_PRIVATE_SUBNET_ID_1: ""
AWS_PRIVATE_SUBNET_ID_2: ""
AWS_PUBLIC_NODE_CIDR: 10.0.0.0/20
AWS_PUBLIC_NODE_CIDR_1: ""
AWS_PUBLIC_NODE_CIDR_2: ""
AWS_PUBLIC_SUBNET_ID: "${public_subnet_id}"
AWS_PUBLIC_SUBNET_ID_1: ""
AWS_PUBLIC_SUBNET_ID_2: ""
AWS_REGION: us-east-2
AWS_SSH_KEY_NAME: ${ssh_key_name}
AWS_VPC_CIDR: 10.0.0.0/16
AWS_VPC_ID: "${vpc_id}"
BASTION_HOST_ENABLED: "true"
CLUSTER_CIDR: 100.96.0.0/11
CLUSTER_NAME: ${workload_cluster_name}
CLUSTER_PLAN: dev
CONTROL_PLANE_MACHINE_TYPE: t3a.2xlarge
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

tanzu cluster create $workload_cluster_name -f .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml --plan dev

tanzu cluster kubeconfig get $workload_cluster_name --admin

read -p "AWS Region Code (us-east-2): " aws_region_code
read -p "Management Cluster Name: " mgmt_cluster_name

if [ -z $aws_region_code ]
then
    aws_region_code=us-east-2
fi

aws ec2 describe-key-pairs

read -p "Input Key Name: " ssh_key_name

if [ -z $ssh_key_name ]
then
    ssh_key_name=${mgmt_cluster_name}-${aws_region_code}
fi

rm .config/tanzu/tkg/clusterconfigs
mkdir .config/tanzu/tkg/clusterconfigs

rm .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
cat <<EOF | tee .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
AWS_AMI_ID: ami-08f4095e19c367152
AWS_NODE_AZ: ${aws_region_code}a
AWS_NODE_AZ_1: ""
AWS_NODE_AZ_2: ""
AWS_PRIVATE_NODE_CIDR: 10.0.16.0/20
AWS_PRIVATE_NODE_CIDR_1: ""
AWS_PRIVATE_NODE_CIDR_2: ""
AWS_PRIVATE_SUBNET_ID: ""
AWS_PRIVATE_SUBNET_ID_1: ""
AWS_PRIVATE_SUBNET_ID_2: ""
AWS_PUBLIC_NODE_CIDR: 10.0.0.0/20
AWS_PUBLIC_NODE_CIDR_1: ""
AWS_PUBLIC_NODE_CIDR_2: ""
AWS_PUBLIC_SUBNET_ID: ""
AWS_PUBLIC_SUBNET_ID_1: ""
AWS_PUBLIC_SUBNET_ID_2: ""
AWS_REGION: us-east-2
AWS_SSH_KEY_NAME: ${ssh_key_name}
AWS_VPC_CIDR: 10.0.0.0/16
AWS_VPC_ID: ""
BASTION_HOST_ENABLED: "true"
CLUSTER_CIDR: 100.96.0.0/11
CLUSTER_NAME: ${mgmt_cluster_name}
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

touch .kube/config

tanzu management-cluster create $mgmt_cluster_name -f .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml

read -p "AWS Region Code (us-east-1): " aws_region_code
read -p "Management Cluster Name (tanzu-management-cluster): " mgmt_cluster_name

if [ -z $aws_region_code ]
then
    aws_region_code=us-east-1
fi

if [ -z $mgmt_cluster_name ]
then
    mgmt_cluster_name=tanzu-management-cluster
fi

aws ec2 describe-key-pairs

read -p "Input Key Name (tanzu-operations-${aws_region_code}): " ssh_key_name

if [ -z $ssh_key_name ]
then
    ssh_key_name=tanzu-operations-${aws_region_code}
fi

rm .config/tanzu/tkg/clusterconfigs
mkdir .config/tanzu/tkg/clusterconfigs

rm .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
cat <<EOF | tee .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml
AWS_NODE_AZ: ${aws_region_code}a
AWS_NODE_AZ_1: ${aws_region_code}b
AWS_NODE_AZ_2: ${aws_region_code}c
AWS_PRIVATE_NODE_CIDR: 10.0.0.0/24
AWS_PRIVATE_NODE_CIDR_1: 10.0.2.0/24
AWS_PRIVATE_NODE_CIDR_2: 10.0.4.0/24
AWS_PRIVATE_SUBNET_ID: ""
AWS_PRIVATE_SUBNET_ID_1: ""
AWS_PRIVATE_SUBNET_ID_2: ""
AWS_PUBLIC_NODE_CIDR: 10.0.1.0/24
AWS_PUBLIC_NODE_CIDR_1: 10.0.3.0/24
AWS_PUBLIC_NODE_CIDR_2: 10.0.5.0/24
AWS_PUBLIC_SUBNET_ID: ""
AWS_PUBLIC_SUBNET_ID_1: ""
AWS_PUBLIC_SUBNET_ID_2: ""
AWS_REGION: ${aws_region_code}
AWS_SSH_KEY_NAME: ${ssh_key_name}
AWS_VPC_CIDR: 10.0.0.0/16
AWS_VPC_ID: ""
BASTION_HOST_ENABLED: "false"
CLUSTER_CIDR: 100.96.0.0/11
CLUSTER_NAME: ${mgmt_cluster_name}
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
NODE_MACHINE_TYPE: m5.large
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

read -p "Management Cluster Name: " mgmt_cluster_name
read -p "AWS Region Code (us-east-2): " aws_region_code

if [[ -z $aws_region_code ]]
then
	aws_region_code=us-east-2
fi

export AWS_REGION=${aws_region_code}

tanzu login

tanzu management-cluster delete

kubectl config delete-context ${mgmt_cluster_name}-admin@${mgmt_cluster_name}
kubectl config delete-cluster ${mgmt_cluster_name}
kubectl config delete-user ${mgmt_cluster_name}-admin

read -p "Workload Cluster Name: " workload_cluster_name
read -p "AWS Region Code (us-east-2): " aws_region_code

if [[ -z $aws_region_code ]]
then
	aws_region_code=us-east-2
fi

export AWS_REGION=${aws_region_code}

tanzu login

tanzu cluster delete $workload_cluster_name

kubectl config delete-context ${workload_cluster_name}-admin@${workload_cluster_name}
kubectl config delete-cluster ${workload_cluster_name}
kubectl config delete-user ${workload_cluster_name}-admin

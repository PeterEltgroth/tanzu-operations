read -p "AWS Region Code (us-east-2): " aws_region_code
read -p "Workload Cluster Name: " workload_cluster_name

if [[ -z $aws_region_code ]]
then
	aws_region_code=us-east-2
fi

export AWS_REGION=${aws_region_code}

tanzu cluster delete $workload_cluster_name

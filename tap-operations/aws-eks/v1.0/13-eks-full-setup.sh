read -p "Full Cluster Name: " full_cluster
read -p "AWS Region Code: " aws_region_code

arn=arn:aws:eks:${aws_region_code}:964978768106:cluster

if [[ $aws_region_code = "us-west-1" ]]
then
	aws eks create-cluster \
	   --name $full_cluster \
	   --region $aws_region_code \
	   --kubernetes-version 1.21 \
	   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
	   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

	aws eks wait cluster-active --name $full_cluster

	aws eks create-nodegroup \
			--cluster-name $full_cluster \
			--nodegroup-name "${full_cluster}-node-group" \
			--disk-size 500 \
			--scaling-config minSize=3,maxSize=3,desiredSize=3 \
			--subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
			--instance-types t3a.2xlarge \
			--node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
			--kubernetes-version 1.21
fi

aws eks wait nodegroup-active --cluster-name $full_cluster --nodegroup-name ${full_cluster}-node-group

aws eks update-kubeconfig --name $full_cluster --region $aws_region_code

kubectl config rename-context ${arn}/${full_cluster} $full_cluster

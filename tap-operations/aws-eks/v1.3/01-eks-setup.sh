read -p "Full Cluster Name: " cluster_name
read -p "AWS Region Code: " aws_region_code

export AWS_ACCOUNT_ID=964978768106
export AWS_REGION=$aws_region_code
export EKS_CLUSTER_NAME=$cluster_name

arn=arn:aws:eks:${AWS_REGION}:964978768106:cluster

if [[ $AWS_REGION = "us-west-1" ]]
then
	aws eks create-cluster \
	   --name $EKS_CLUSTER_NAME \
	   --region $AWS_REGION \
	   --kubernetes-version 1.23 \
	   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
	   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

	aws eks wait cluster-active --name $EKS_CLUSTER_NAME

	aws eks create-nodegroup \
			--cluster-name $EKS_CLUSTER_NAME \
			--nodegroup-name "${EKS_CLUSTER_NAME}-node-group" \
			--disk-size 100 \
			--scaling-config minSize=3,maxSize=3,desiredSize=3 \
			--subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
			--instance-types m5.2xlarge \
			--node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
			--kubernetes-version 1.23
fi

aws eks wait nodegroup-active --cluster-name $EKS_CLUSTER_NAME --nodegroup-name ${EKS_CLUSTER_NAME}-node-group

rm $HOME/.kube/config

aws eks update-kubeconfig --name $EKS_CLUSTER_NAME --region $AWS_REGION

kubectl config rename-context ${arn}/${EKS_CLUSTER_NAME} $EKS_CLUSTER_NAME

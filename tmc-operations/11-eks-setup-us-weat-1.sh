aws_region_code=ap-northeast-1
access_cluster_group=eks-access-cluster-group
quota_cluster_group=eks-quota-cluster-group
custom_cluster_group=eks-custom-cluster-group


#TMC-ACCESS-CLUSTER
aws eks create-cluster \
   --region $aws_region_code \
   --name $access_cluster_group \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

aws eks wait cluster-active --name $access_cluster_group

aws eks create-nodegroup \
        --cluster-name $access_cluster_group \
        --nodegroup-name "${access_cluster_group}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=1,maxSize=1,desiredSize=1 \
        --subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21


#TMC-QUOTA-CLUSTER
aws eks create-cluster \
   --region $aws_region_code \
   --name $quota_cluster_group \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

aws eks wait cluster-active --name $quota_cluster_group

aws eks create-nodegroup \
        --cluster-name $quota_cluster_group \
        --nodegroup-name "${quota_cluster_group}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=1,maxSize=1,desiredSize=1 \
        --subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21


#TMC-CUSTOM-CLUSTER
aws eks create-cluster \
   --region $aws_region_code \
   --name $custom_cluster_group \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

aws eks wait cluster-active --name $custom_cluster_group

aws eks create-nodegroup \
        --cluster-name $custom_cluster_group \
        --nodegroup-name "${custom_cluster_group}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=1,maxSize=1,desiredSize=1 \
        --subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21
		
aws eks wait nodegroup-active --cluster-name $custom_cluster_group --nodegroup-name ${custom_cluster_group}-node-group

rm .kube/config

aws eks update-kubeconfig --name $access_cluster_group --region $aws_region_code
aws eks update-kubeconfig --name $quota_cluster_group --region $aws_region_code
aws eks update-kubeconfig --name $custom_cluster_group --region $aws_region_code

arn=arn:aws:eks:ap-northeast-1:964978768106:cluster
kubectl config rename-context ${arn}/${access_cluster_group} $access_cluster_group
kubectl config rename-context ${arn}/${quota_cluster_group} $quota_cluster_group
kubectl config rename-context ${arn}/${custom_cluster_group} $custom_cluster_group


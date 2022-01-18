aws_region_code=ap-northeast-1
access_cluster_group=tmc-access-cluster-group
quota_cluster_group=tmc-quota-cluster-group
custom_cluster_group=tmc-custom-cluster-group


#TMC-ACCESS-CLUSTER
aws eks create-cluster \
   --region $aws_region_code \
   --name $access_cluster_group \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-63b6632b,subnet-a6bc608d,subnet-5441460f

aws eks wait cluster-active --name $access_cluster_group

aws eks create-nodegroup \
        --cluster-name $access_cluster_group \
        --nodegroup-name "${access_cluster_group}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=1,maxSize=1,desiredSize=1 \
        --subnets "subnet-63b6632b" "subnet-a6bc608d" "subnet-5441460f" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21


#TMC-QUOTA-CLUSTER
aws eks create-cluster \
   --region $aws_region_code \
   --name $quota_cluster_group \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-63b6632b,subnet-a6bc608d,subnet-5441460f

aws eks wait cluster-active --name $quota_cluster_group

aws eks create-nodegroup \
        --cluster-name $quota_cluster_group \
        --nodegroup-name "${quota_cluster_group}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=1,maxSize=1,desiredSize=1 \
        --subnets "subnet-63b6632b" "subnet-a6bc608d" "subnet-5441460f" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21


#TMC-CUSTOM-CLUSTER
aws eks create-cluster \
   --region $aws_region_code \
   --name $custom_cluster_group \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-63b6632b,subnet-a6bc608d,subnet-5441460f

aws eks wait cluster-active --name $custom_cluster_group

aws eks create-nodegroup \
        --cluster-name $custom_cluster_group \
        --nodegroup-name "${custom_cluster_group}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=1,maxSize=1,desiredSize=1 \
        --subnets "subnet-63b6632b" "subnet-a6bc608d" "subnet-5441460f" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21
		
aws eks wait nodegroup-active --cluster-name $custom_cluster_group --nodegroup-name ${custom_cluster_group}-node-group

rm .kube/config

aws eks update-kubeconfig --name $access_cluster_group --region $aws_region_code
aws eks update-kubeconfig --name $quota_cluster_group --region $aws_region_code
aws eks update-kubeconfig --name $custom_cluster_group --region $aws_region_code


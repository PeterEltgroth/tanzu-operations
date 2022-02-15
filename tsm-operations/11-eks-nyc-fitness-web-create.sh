read -p "AWS Region Code (us-east-2): " aws_region_code

if [ -z $aws_region_code ]
then
    aws_region_code=us-east-2
fi

cluster_name=nyc-fitness-web
arn=arn:aws:eks:${aws_region_code}:964978768106:cluster

aws eks create-cluster \
   --region $aws_region_code \
   --name $cluster_name \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0d01ac4a005d833fd,subnet-0ac6020705178c3b5,subnet-0f315a4b0eb3c0e88

aws eks wait cluster-active --name $cluster_name

aws eks create-nodegroup \
        --cluster-name $cluster_name \
        --nodegroup-name "${cluster_name}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=3,maxSize=3,desiredSize=3 \
        --subnets "subnet-0d01ac4a005d833fd" "subnet-0ac6020705178c3b5" "subnet-0f315a4b0eb3c0e88" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21

aws eks wait nodegroup-active --cluster-name $cluster_name --nodegroup-name ${cluster_name}-node-group

aws eks update-kubeconfig --name $cluster_name --region $aws_region_code

kubectl config rename-context ${arn}/${cluster_name} $cluster_name


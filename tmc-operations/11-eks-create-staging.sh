read -p "EKS Region Code (us-east-2): " aws_region_code

if [ -z $aws_region_code ]
then
    aws_region_code=us-east-2
fi

tmc_staging_cluster=tmc-staging-cluster
arn=arn:aws:eks:${aws_region_code}:964978768106:cluster

aws eks create-cluster \
   --region $aws_region_code \
   --name $tmc_staging_cluster \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0d01ac4a005d833fd,subnet-0ac6020705178c3b5,subnet-0f315a4b0eb3c0e88

aws eks wait cluster-active --name $tmc_staging_cluster

aws eks create-nodegroup \
        --cluster-name $tmc_staging_cluster \
        --nodegroup-name "${tmc_staging_cluster}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=1,maxSize=1,desiredSize=1 \
        --subnets "subnet-0d01ac4a005d833fd" "subnet-0ac6020705178c3b5" "subnet-0f315a4b0eb3c0e88" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21

aws eks wait nodegroup-active --cluster-name $tmc_staging_cluster --nodegroup-name ${tmc_staging_cluster}-node-group

aws eks update-kubeconfig --name $tmc_staging_cluster --region $aws_region_code

kubectl config rename-context ${arn}/${tmc_staging_cluster} $tmc_staging_cluster


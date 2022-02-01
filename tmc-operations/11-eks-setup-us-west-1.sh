aws_region_code=us-west-1
tmc_access_cluster=tmc-access-cluster
tmc_custom_cluster=tmc-custom-cluster


#TMC-ACCESS-CLUSTER
#aws eks create-cluster \
#   --region $aws_region_code \
#   --name $tmc_access_cluster \
#   --kubernetes-version 1.21 \
#   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
#   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

#aws eks wait cluster-active --name $tmc_access_cluster

#aws eks create-nodegroup \
#        --cluster-name $tmc_access_cluster \
#        --nodegroup-name "${tmc_access_cluster}-node-group" \
#        --disk-size 500 \
#        --scaling-config minSize=1,maxSize=1,desiredSize=1 \
#        --subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
#        --instance-types t3a.2xlarge \
#        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
#        --kubernetes-version 1.21


#TMC-CUSTOM-CLUSTER
aws eks create-cluster \
   --region $aws_region_code \
   --name $tmc_custom_cluster \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

aws eks wait cluster-active --name $tmc_custom_cluster

aws eks create-nodegroup \
        --cluster-name $tmc_custom_cluster \
        --nodegroup-name "${tmc_custom_cluster}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=1,maxSize=1,desiredSize=1 \
        --subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21
		
aws eks wait nodegroup-active --cluster-name $tmc_custom_cluster --nodegroup-name ${tmc_custom_cluster}-node-group

rm .kube/config

#aws eks update-kubeconfig --name $tmc_access_cluster --region $aws_region_code
aws eks update-kubeconfig --name $tmc_custom_cluster --region $aws_region_code

arn=arn:aws:eks:us-west-1:964978768106:cluster
#kubectl config rename-context ${arn}/${tmc_access_cluster} $tmc_access_cluster
kubectl config rename-context ${arn}/${tmc_custom_cluster} $tmc_custom_cluster


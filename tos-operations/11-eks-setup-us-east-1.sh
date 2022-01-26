aws_region_code=us-east-1
tos_tracing_cluster=tos-tracing-cluster


#TOS TRACING-CLUSTER
aws eks create-cluster \
   --region $aws_region_code \
   --name $tos_tracing_cluster \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0153c75f91ed045a8,subnet-0bc27bb89b888e579,subnet-04b9bef1f2600ea20,subnet-054820597f34b428a,subnet-013511b2897332ad0,subnet-0a98e6bcbe7f1ad5a

aws eks wait cluster-active --name $tos_tracing_cluster

aws eks create-nodegroup \
        --cluster-name $tos_tracing_cluster \
        --nodegroup-name "${tos_tracing_cluster}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=2,maxSize=2,desiredSize=2 \
        --subnets "subnet-0153c75f91ed045a8" "subnet-0bc27bb89b888e579" "04b9bef1f2600ea20" "054820597f34b428a" "054820597f34b428a" "013511b2897332ad0" "0a98e6bcbe7f1ad5a" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21

rm .kube/config

aws eks update-kubeconfig --name $tos_tracing_cluster --region $aws_region_code


arn=arn:aws:eks:us-east-1:964978768106:cluster
kubectl config rename-context ${arn}/${tos_tracing_cluster} $tos_tracing_cluster


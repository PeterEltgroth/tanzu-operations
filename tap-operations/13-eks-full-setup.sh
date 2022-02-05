read -p "Full Cluster Name: " eks_full_cluster
read -p "Build Cluster Name: " eks_build_cluster
read -p "Run Cluster Name: " eks_run_cluster

#TAP-FULL-CLUSTER
aws eks create-cluster \
   --name $eks_full_cluster \
   --region us-west-1 \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

aws eks wait cluster-active --name $eks_full_cluster

aws eks create-nodegroup \
        --cluster-name $eks_full_cluster \
        --nodegroup-name "${eks_full_cluster}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=3,maxSize=3,desiredSize=3 \
        --subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21


#TAP-BUILD-CLUSTER
aws eks create-cluster \
   --name $eks_build_cluster \
   --region us-west-1 \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

aws eks wait cluster-active --name $eks_build_cluster

aws eks create-nodegroup \
        --cluster-name $eks_build_cluster \
        --nodegroup-name "${eks_build_cluster}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=3,maxSize=3,desiredSize=3 \
        --subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21
		

#TAP-RUN-CLUSTER
aws eks create-cluster \
   --name $eks_run_cluster \
   --region us-west-1 \
   --kubernetes-version 1.21 \
   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

aws eks wait cluster-active --name $eks_run_cluster

aws eks create-nodegroup \
        --cluster-name $eks_run_cluster \
        --nodegroup-name "${eks_run_cluster}-node-group" \
        --disk-size 500 \
        --scaling-config minSize=3,maxSize=3,desiredSize=3 \
        --subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
        --instance-types t3a.2xlarge \
        --node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
        --kubernetes-version 1.21
		
aws eks wait nodegroup-active --cluster-name $eks_run_cluster --nodegroup-name ${eks_run_cluster}-node-group

rm .kube/config

aws eks update-kubeconfig --name $eks_full_cluster --region us-west-1
aws eks update-kubeconfig --name $eks_build_cluster --region us-west-1
aws eks update-kubeconfig --name $eks_run_cluster --region us-west-1

arn=arn:aws:eks:us-west-1:964978768106:cluster
kubectl config rename-context ${arn}/${eks_full_cluster} $eks_full_cluster
kubectl config rename-context ${arn}/${eks_build_cluster} $eks_build_cluster
kubectl config rename-context ${arn}/${eks_run_cluster} $eks_run_cluster


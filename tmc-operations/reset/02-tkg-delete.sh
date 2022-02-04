#!/bin/bash

read -p "AWS Region Code (us-east-2): " aws_region_code
read -p "Workload Cluster Name: " workload_cluster_name
read -p "Management Cluster Name: " mgmt_cluster_name

if [ -z $aws_region_code ]
then
    aws_region_code=us-east-2
fi

tanzu cluster delete $workload_cluster_name --yes

kubectl config delete-user ${workload_cluster_name}-admin
kubectl config delete-cluster ${workload_cluster_name}
kubectl config delete-context ${workload_cluster_name}-admin@${workload_cluster_name}

#BUG IN 1.4 REQUIRES AWS_REGION BE SET MANUALLY
export AWS_REGION=${aws_region_code}
tanzu management-cluster delete $mgmt_cluster_name --yes

#it seems the tanzu cli removed the cluster and context from kubeconfig
kubectl config delete-user ${mgmt_cluster_name}-admin
#kubectl config delete-cluster ${mgmt_cluster_name}
#kubectl config delete-context ${mgmt_cluster_name}

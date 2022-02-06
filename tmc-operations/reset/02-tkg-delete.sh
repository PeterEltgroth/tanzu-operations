#!/bin/bash

tmc cluster list

read -p "Cluster Name: " cluster_name

tmc cluster delete $cluster_name --management-cluster-name aws-hosted --provisioner-name tmc-aws-provisioner













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

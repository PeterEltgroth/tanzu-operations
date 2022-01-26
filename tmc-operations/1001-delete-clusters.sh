#!/bin/bash

#EKS CLUSTERS
arn=arn:aws:eks:us-west-1:964978768106:cluster

tmc_access_cluster=tmc-access-cluster
tmc_quota_cluster=tmc-quota-cluster
tmc_custom_cluster=tmc-custom-cluster
tmc_security_cluster=tmc-security-cluster
tmc_registry_and_network_cluster=tmc-registry-and-network-cluster

#DELETE TMC-ACCESS-CLUSTER
kubectl config use-context $tmc_access_cluster

aws eks delete-nodegroup --cluster-name $tmc_access_cluster --nodegroup-name ${tmc_access_cluster}-node-group
aws eks wait nodegroup-active --cluster-name $tmc_access_cluster --nodegroup-name ${tmc_access_cluster}-node-group

kubectl config delete-user $arn/$tmc_access_cluster
kubectl config delete-cluster $arn/$tmc_access_cluster
kubectl config delete-context $tmc_access_cluster

aws eks delete-cluster --name $tmc_access_cluster


#DELETE TMC-QUOTA-CLUSTER
kubectl config use-context $tmc_quota_cluster

aws eks delete-nodegroup --cluster-name $tmc_quota_cluster --nodegroup-name ${tmc_quota_cluster}-node-group
aws eks wait nodegroup-active --cluster-name $tmc_quota_cluster --nodegroup-name ${tmc_quota_cluster}-node-group

kubectl config delete-user $arn/$tmc_quota_cluster
kubectl config delete-cluster $arn/$tmc_quota_cluster
kubectl config delete-context $tmc_quota_cluster

aws eks delete-cluster --name $tmc_quota_cluster


#DELETE TMC-CUSTOM-CLUSTER
kubectl config use-context $tmc_custom_cluster

aws eks delete-nodegroup --cluster-name $tmc_custom_cluster --nodegroup-name ${tmc_custom_cluster}-node-group
aws eks wait nodegroup-active --cluster-name $tmc_custom_cluster --nodegroup-name ${tmc_custom_cluster}-node-group

kubectl config delete-user $arn/$tmc_custom_cluster
kubectl config delete-cluster $arn/$tmc_custom_cluster
kubectl config delete-context $tmc_custom_cluster

aws eks delete-cluster --name $tmc_custom_cluster


#DELETE ELASTIC LOAD BALANCERS
aws elb describe-load-balancers

read -p "Load Balancer Name: " lb_name

aws elb delete-load-balancer --load-balancer-name $lb_name


#DELETE GKE REGISTRY AND NETWORK CLUSTER
prefix=gke_pa-mjames_us-west1

gcloud container clusters delete "${tmc_registry_and_network_cluster}" --region "us-west1"

kubectl config delete-user ${prefix}_${tmc_registry_and_network_cluster}
kubectl config delete-cluster ${prefix}_${tmc_registry_and_network_cluster}
kubectl config delete-context ${tmc_registry_and_network_cluster}


#DELETE AKS SECURITY CLUSTER
prefix=clusterUser_tanzu-mission-control

az aks delete --name $tmc_security_cluster --resource-group tanzu-mission-control

kubectl config delete-user ${prefix}_${tmc_security_cluster}
kubectl config delete-cluster ${tmc_security_cluster}
kubectl config delete-context ${tmc_security_cluster}

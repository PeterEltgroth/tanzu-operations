#!/bin/bash

#EKS CLUSTERS
arn=arn:aws:eks:us-east-2:964978768106:cluster

tmc_access_cluster=tmc-access-cluster
tmc_quota_cluster_gke=tmc-quota-cluster-gke
tmc_quota_cluster_aks=tmc-quota-cluster-aks
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


#DELETE TMC-SECURITY-CLUSTER
kubectl config use-context $tmc_security_cluster

aws eks delete-nodegroup --cluster-name $tmc_security_cluster --nodegroup-name ${tmc_security_cluster}-node-group
aws eks wait nodegroup-active --cluster-name $tmc_security_cluster --nodegroup-name ${tmc_security_cluster}-node-group

kubectl config delete-user $arn/$tmc_security_cluster
kubectl config delete-cluster $arn/$tmc_security_cluster
kubectl config delete-context $tmc_security_cluster

aws eks delete-cluster --name $tmc_security_cluster


#DELETE TMC-CUSTOM-CLUSTER
kubectl config use-context $tmc_custom_cluster

aws eks delete-nodegroup --cluster-name $tmc_custom_cluster --nodegroup-name ${tmc_custom_cluster}-node-group
aws eks wait nodegroup-active --cluster-name $tmc_custom_cluster --nodegroup-name ${tmc_custom_cluster}-node-group

kubectl config delete-user $arn/$tmc_custom_cluster
kubectl config delete-cluster $arn/$tmc_custom_cluster
kubectl config delete-context $tmc_custom_cluster

aws eks delete-cluster --name $tmc_custom_cluster


#DELETE ELASTIC LOAD BALANCERS
#aws elb describe-load-balancers --output text --query "LoadBalancerDescriptions[*].[LoadBalancerName]"

#read -p "Load Balancer Name: " lb_name

#aws elb delete-load-balancer --load-balancer-name $lb_name


#DELETE GKE REGISTRY AND NETWORK CLUSTER
gke_region_code=us-east1
prefix=gke_pa-mjames_${gke_region_code}

gcloud container clusters delete "${tmc_registry_and_network_cluster}" --region $gke_region_code

#kubectl config delete-user ${prefix}_${tmc_registry_and_network_cluster}
#kubectl config delete-cluster ${prefix}_${tmc_registry_and_network_cluster}
kubectl config delete-context ${tmc_registry_and_network_cluster}

#DELETE GKE QUOTA CLUSTER
gcloud container clusters delete "${tmc_quota_cluster_gke}" --region $gke_region_code

#kubectl config delete-user ${prefix}_${tmc_quota_cluster_gke}
#kubectl config delete-cluster ${prefix}_${tmc_quota_cluster_gke}
kubectl config delete-context ${tmc_quota_cluster_gke}


#DELETE AKS QUOTA CLUSTER
prefix=clusterUser_tanzu-mission-control
az aks delete --name $tmc_quota_cluster_aks --resource-group tanzu-mission-control

kubectl config delete-user ${prefix}_${tmc_quota_cluster_aks}
kubectl config delete-cluster ${tmc_quota_cluster_aks}
kubectl config delete-context ${tmc_quota_cluster_aks}

#!/bin/bash

arn=arn:aws:eks:ap-northeast-1:964978768106:cluster

#EKS CLUSTERS
access_cluster_group=tmc-access-cluster-group
quota_cluster_group=tmc-quota-cluster-group
custom_cluster_group=tmc-custom-cluster-group

#GKE CLUSTERS
security_cluster_group=tmc-security-cluster-group

#AKS CLUSTERS
registry_and_network_cluster=tmc-registry-and-network-cluster


#DELETE TMC-ACCESS-CLUSTER
kubectl config use-context $arn/$access_cluster_group

aws eks delete-nodegroup --cluster-name $access_cluster_group --nodegroup-name ${access_cluster_group}-node-group
aws eks wait nodegroup-active --cluster-name $access_cluster_group --nodegroup-name ${access_cluster_group}-node-group

kubectl get svc --all-namespaces
read -p "Service Name: " service_name

if [ -z "$service_name" ]
then
	echo "Service not found"
else
	kubectl delete svc $service_name
fi

kubectl config delete-user $arn/$access_cluster_group
kubectl config delete-cluster $arn/$access_cluster_group
kubectl config delete-context $arn/$access_cluster_group

aws eks delete-cluster --name $access_cluster_group


#DELETE TMC-QUOTA-CLUSTER
kubectl config use-context $arn/$quota_cluster_group

aws eks delete-nodegroup --cluster-name $quota_cluster_group --nodegroup-name ${quota_cluster_group}-node-group
aws eks wait nodegroup-active --cluster-name $quota_cluster_group --nodegroup-name ${quota_cluster_group}-node-group

kubectl get svc --all-namespaces
read -p "Service Name: " service_name

if [ -z "$service_name" ]
then
	echo "Service not found"
else
	kubectl delete svc $service_name
fi

kubectl config delete-user $arn/$quota_cluster_group
kubectl config delete-cluster $arn/$quota_cluster_group
kubectl config delete-context $arn/$quota_cluster_group

aws eks delete-cluster --name $quota_cluster_group



#DELETE TMC-CUSTOM-CLUSTER
kubectl config use-context $arn/$custom_cluster_group

aws eks delete-nodegroup --cluster-name $custom_cluster_group --nodegroup-name ${custom_cluster_group}-node-group
aws eks wait nodegroup-active --cluster-name $custom_cluster_group --nodegroup-name ${custom_cluster_group}-node-group

kubectl get svc --all-namespaces
read -p "Service Name: " service_name

if [ -z "$service_name" ]
then
	echo "Service not found"
else
	kubectl delete svc $service_name
fi

kubectl config delete-user $arn/$custom_cluster_group
kubectl config delete-cluster $arn/$custom_cluster_group
kubectl config delete-context $arn/$custom_cluster_group

aws eks delete-cluster --name $custom_cluster_group


#DELETE AKS CLUSTERS
az aks delete --name $registry_and_network_cluster --resource-group tanzu-mission-control


#DELETE TMC-SECURITY-CLUSTER
gcloud container clusters delete "${security_cluster_group}" --region "asia-northeast1"

prefix=gke_pa-mjames_asia-northeast1
kubectl config delete-user ${prefix}_${security_cluster_group}
kubectl config delete-cluster ${prefix}_${security_cluster_group}
kubectl config delete-context ${prefix}_${security_cluster_group}
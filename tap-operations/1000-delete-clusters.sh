#!/bin/bash

read -p "Full Cluster Name: " eks_full_cluster
read -p "Build Cluster Name: " eks_build_cluster
read -p "Run Cluster Name: " eks_run_cluster

#EKS CLUSTERS
arn=arn:aws:eks:us-west-1:964978768106:cluster

#DELETE FULL CLUSTER
kubectl config use-context $eks_full_cluster

aws eks delete-nodegroup --cluster-name $eks_full_cluster --nodegroup-name ${eks_full_cluster}-node-group
aws eks wait nodegroup-active --cluster-name $eks_full_cluster --nodegroup-name ${eks_full_cluster}-node-group

kubectl get svc --all-namespaces
read -p "Service Name: " service_name

if [ -z "$service_name" ]
then
	echo "Service not found"
else
	kubectl delete svc $service_name
fi

kubectl config delete-user $arn/$eks_full_cluster
kubectl config delete-cluster $arn/$eks_full_cluster
kubectl config delete-context $eks_full_cluster

aws eks delete-cluster --name $eks_full_cluster


#DELETE BUILD CLUSTER
kubectl config use-context $eks_build_cluster

aws eks delete-nodegroup --cluster-name $eks_build_cluster --nodegroup-name ${eks_build_cluster}-node-group
aws eks wait nodegroup-active --cluster-name $eks_build_cluster --nodegroup-name ${eks_build_cluster}-node-group

kubectl get svc --all-namespaces
read -p "Service Name: " service_name

if [ -z "$service_name" ]
then
	echo "Service not found"
else
	kubectl delete svc $service_name
fi

kubectl config delete-user $arn/$eks_build_cluster
kubectl config delete-cluster $arn/$eks_build_cluster
kubectl config delete-context $eks_build_cluster

aws eks delete-cluster --name $eks_build_cluster


#DELETE RUN CLUSTER
kubectl config use-context $eks_run_cluster

aws eks delete-nodegroup --cluster-name $eks_run_cluster --nodegroup-name ${eks_run_cluster}-node-group
aws eks wait nodegroup-active --cluster-name $eks_run_cluster --nodegroup-name ${eks_run_cluster}-node-group

kubectl get svc --all-namespaces
read -p "Service Name: " service_name

if [ -z "$service_name" ]
then
	echo "Service not found"
else
	kubectl delete svc $service_name
fi

kubectl config delete-user $arn/$eks_run_cluster
kubectl config delete-cluster $arn/$eks_run_cluster
kubectl config delete-context $eks_run_cluster

aws eks delete-cluster --name $eks_run_cluster
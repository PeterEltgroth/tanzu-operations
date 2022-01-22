#!/bin/bash

read -p "EKS Cluster Name: " eks_cluster_name

#EKS CLUSTERS
arn=arn:aws:eks:us-west-1:964978768106:cluster

#DELETE FULL CLUSTER
kubectl config use-context $eks_cluster_name

aws eks delete-nodegroup --cluster-name $eks_cluster_name --nodegroup-name ${eks_cluster_name}-node-group
aws eks wait nodegroup-active --cluster-name $eks_cluster_name --nodegroup-name ${eks_cluster_name}-node-group

kubectl config delete-user $arn/$eks_cluster_name
kubectl config delete-cluster $arn/$eks_cluster_name
kubectl config delete-context $eks_cluster_name

aws eks delete-cluster --name $eks_cluster_name

aws elb describe-load-balancers

read -p "Load Balancer Name: " lb_name

aws elb delete-load-balancer --load-balancer-name $lb_name
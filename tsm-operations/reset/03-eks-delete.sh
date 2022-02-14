#!/bin/bash

read -p "AWS Region Code (us-east-2): " aws_region_code

if [ -z $aws_region_code ]
then
    aws_region_code=us-east-2
fi

cluster_name=tmc-staging-cluster
arn=arn:aws:eks:${aws_region_code}:964978768106:cluster

aws eks delete-nodegroup --cluster-name $cluster_name --nodegroup-name ${cluster_name}-node-group
aws eks wait nodegroup-active --cluster-name $cluster_name --nodegroup-name ${cluster_name}-node-group

aws eks delete-cluster --name $cluster_name

kubectl config delete-user $arn/$cluster_name
kubectl config delete-cluster $arn/$cluster_name
kubectl config delete-context $cluster_name

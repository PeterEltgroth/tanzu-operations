#!/bin/bash

read -p "AWS Region Code (us-east-2): " aws_region_code

if [ -z $aws_region_code ]
then
    aws_region_code=us-east-2
fi

tmc_development_cluster=tmc-development-cluster
arn=arn:aws:eks:${aws_region_code}:964978768106:cluster

aws eks delete-nodegroup --cluster-name $tmc_development_cluster --nodegroup-name ${tmc_development_cluster}-node-group
aws eks wait nodegroup-active --cluster-name $tmc_development_cluster --nodegroup-name ${tmc_development_cluster}-node-group

aws eks delete-cluster --name $tmc_development_cluster

kubectl config delete-user $arn/$tmc_development_cluster
kubectl config delete-cluster $arn/$tmc_development_cluster
kubectl config delete-context $tmc_development_cluster

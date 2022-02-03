#!/bin/bash

prefix=clusterUser_tanzu-mission-control
cluster_name=tmc-development-cluster

az aks delete --name $cluster_name --resource-group tanzu-mission-control

kubectl config delete-user ${prefix}_${cluster_name}
kubectl config delete-cluster ${cluster_name}
kubectl config delete-context ${cluster_name}

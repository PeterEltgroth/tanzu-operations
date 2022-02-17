#!/bin/bash

prefix=clusterUser_tanzu-service-mesh
cluster_name=tsm-fitness-web

az aks delete --name $cluster_name --resource-group tanzu-service-mesh

kubectl config delete-user ${prefix}_${cluster_name}
kubectl config delete-cluster ${cluster_name}
kubectl config delete-context ${cluster_name}

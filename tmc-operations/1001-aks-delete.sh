#!/bin/bash

prefix=clusterUser_tanzu-mission-control
tmc_staging_cluster=tmc-staging-cluster

az aks delete --name $tmc_staging_cluster --resource-group tanzu-mission-control

kubectl config delete-user ${prefix}_${tmc_staging_cluster}
kubectl config delete-cluster ${tmc_staging_cluster}
kubectl config delete-context ${tmc_staging_cluster}

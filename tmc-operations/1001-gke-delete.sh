#!/bin/bash

read -p "GKE Region Code (us-east1): " gke_region_code

if [ -z $gke_region_code ]
then
    gke_region_code=us-east1
fi

cluster_name=tmc-production-cluster

#DELETE GKE REGISTRY AND NETWORK CLUSTER
prefix=gke_pa-mjames_${gke_region_code}

gcloud container clusters delete "${cluster_name}" --region $gke_region_code

kubectl config delete-context ${cluster_name}

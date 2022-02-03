#!/bin/bash

read -p "GKE Region Code (us-east1): " gke_region_code

if [ -z $gke_region_code ]
then
    gke_region_code=us-east1
fi

tmc_production_cluster=tmc-production-cluster

#DELETE GKE REGISTRY AND NETWORK CLUSTER
prefix=gke_pa-mjames_${gke_region_code}

gcloud container clusters delete "${tmc_production_cluster}" --region $gke_region_code

kubectl config delete-context ${tmc_production_cluster}

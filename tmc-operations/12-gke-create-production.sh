read -p "GKE Region Code (us-east1): " gke_region_code

if [ -z $gke_region_code ]
then
    gke_region_code=us-east1
fi

cluster_name=tmc-production-cluster


#QUOTA POLICY CLUSTER
gcloud container clusters create "${cluster_name}" --region "${gke_region_code}" --no-enable-basic-auth --cluster-version "1.21.6-gke.1503" --release-channel "None" --machine-type "e2-standard-4" --image-type "COS" --disk-type "pd-standard" --disk-size "200" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "3" --enable-stackdriver-kubernetes --enable-ip-alias --network "projects/pa-mjames/global/networks/default" --subnetwork "projects/pa-mjames/regions/${gke_region_code}/subnetworks/default" --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0 --enable-network-policy
		
gcloud container clusters get-credentials "${cluster_name}" --region "${gke_region_code}"

prefix=gke_pa-mjames_${gke_region_code}
kubectl config rename-context ${prefix}_${cluster_name} ${cluster_name}

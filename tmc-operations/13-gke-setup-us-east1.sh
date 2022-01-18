gke_region_code=asia-northeast1
security_cluster_group=tmc-security-cluster-group

#TMC-SECURITY-CLUSTER
gcloud container clusters create "${security_cluster_group}" --region "${gke_region_code}" --no-enable-basic-auth --cluster-version "1.21.5-gke.1302" --release-channel "None" --machine-type "e2-standard-4" --image-type "COS" --disk-type "pd-standard" --disk-size "200" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "1" --enable-stackdriver-kubernetes --enable-ip-alias --network "projects/pa-mjames/global/networks/default" --subnetwork "projects/pa-mjames/regions/${gke_region_code}/subnetworks/default" --default-max-pods-per-node "110" --no-enable-master-authorized-networks --addons HorizontalPodAutoscaling,HttpLoadBalancing --enable-autoupgrade --enable-autorepair --max-surge-upgrade 1 --max-unavailable-upgrade 0
		
gcloud container clusters get-credentials "${security_cluster_group}" --region "${gke_region_code}"

prefix=gke_pa-mjames_asia-northeast1
kubectl config rename-context ${prefix}_${security_cluster_group} ${security_cluster_group}
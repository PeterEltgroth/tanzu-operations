read -p "Azure Subscription: " subscription

development_cluster_group=development-cluster-group
production_cluster_group=production-cluster-group

tmc_build_cluster=tmc-build-cluster
tmc_development_cluster=tmc-development-cluster
tmc_staging_cluster=tmc-staging-cluster
tmc_production_cluster=tmc-production-cluster

TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login
echo


#CREATE CLUSTER GROUPS
read -p "Create cluster groups"
echo

tmc clustergroup create --name $development_cluster_group #--description "Demonstrates the cluster-only policies; security, and custom."
tmc clustergroup create --name $production_cluster_group #--description "Demonstrates the cluster-only quota policy."
echo


#ATTACH BUILD CLUSTER
read -p "Attach TKG Build Cluster"
echo

kubectl config use-context ${tmc_build_cluster}-admin@${tmc_build_cluster}
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $tmc_build_cluster --cluster-group $development_cluster_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo


#ATTACH DEVELOPMENT CLUSTER
read -p "Attach AKS Development Cluster"
echo

kubectl config use-context $tmc_development_cluster
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $tmc_development_cluster --cluster-group $development_cluster_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo


#ATTACH STAGING CLUSTER
read -p "Attach EKS Staging Cluster"
echo

kubectl config use-context $tmc_staging_cluster
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $tmc_staging_cluster --cluster-group $development_cluster_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo


#ATTACH STAGING CLUSTER
read -p "Attach GKE Production Cluster"
echo

kubectl config use-context $tmc_production_cluster
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $tmc_production_cluster --cluster-group $production_cluster_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo

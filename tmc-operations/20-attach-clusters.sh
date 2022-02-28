read -p "Azure Subscription: " subscription

development_cluster_group=development-cluster-group

tmc_development_cluster=tmc-development-cluster
tmc_staging_cluster=tmc-staging-cluster


#CREATE CLUSTER GROUPS
echo
read -p "Create cluster groups"
echo

tmc clustergroup create --name $development_cluster_group #--description "Demonstrates the cluster-only policies; security, and custom."
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

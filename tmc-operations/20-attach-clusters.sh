read -p "Azure Subscription: " subscription

cluster_group=cluster-group
quota_group=quota-group
tmc_access_cluster=tmc-access-cluster
tmc_custom_cluster=tmc-custom-cluster
tmc_quota_cluster_gke=tmc-quota-cluster-gke
tmc_quota_cluster_aks=tmc-quota-cluster-aks
tmc_security_cluster=tmc-security-cluster


TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login
echo

#CREATE CLUSTER GROUPS
read -p "Create cluster groups"
echo

tmc clustergroup create --name $cluster_group --description "Demonstrates the cluster-only policies; security, and custom."
tmc clustergroup create --name $quota_group --description "Demonstrates the cluster-only quota policy."
echo


#CREATE EKS ACCESS CLUSTER
read -p "Attach EKS Access Cluster"
echo

kubectl config use-context $tmc_access_cluster
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $tmc_access_cluster --cluster-group $cluster_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo


#CREATE EKS CUSTOM CLUSTER
read -p "Attach EKS Custom Cluster"
echo

kubectl config use-context $tmc_custom_cluster
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $tmc_custom_cluster --cluster-group $cluster_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo


#CREATE GKE QUOTA CLUSTER
read -p "Attach GKE Quota Cluster"
echo

kubectl config use-context $tmc_quota_cluster_gke
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $tmc_quota_cluster_gke --cluster-group $quota_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo


#CREATE AKS SECURITY CLUSTER
read -p "Attach AKS Security Cluster"
echo

kubectl config use-context $tmc_security_cluster
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $tmc_security_cluster --cluster-group $quota_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo


#CREATE AKS QUOTA CLUSTER
read -p "Attach AKS QUOTA Cluster"
echo

kubectl config use-context $tmc_quota_cluster_aks
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $tmc_quota_cluster_aks --cluster-group $quota_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo
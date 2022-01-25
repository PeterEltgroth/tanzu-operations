read -p "Azure Subscription: " subscription

cluster_group=cluster-group
#access_cluster=access-cluster
quota_cluster=quota-cluster
#custom_cluster=custom-cluster
#security_cluster=security-cluster


TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login
echo

#CREATE CLUSTER GROUPS
read -p "Create cluster groups"
echo

tmc clustergroup create --name $cluster_group --description "Demonstrates the cluster-only policies; security, quota, and custom."
echo


#CREATE EKS ACCESS CLUSTER
#read -p "Attach EKS Access Cluster"
#echo

#kubectl config use-context $access_cluster_group
#echo

#rm ./k8s-attach-manifest.yaml
#tmc cluster attach --name $access_cluster_group --cluster-group $cluster_group
#echo

#kubectl apply -f ./k8s-attach-manifest.yaml
#echo


#CREATE EKS CUSTOM CLUSTER
#read -p "Attach EKS Custom Cluster"
#echo

#kubectl config use-context $custom_cluster_group
#echo

#rm ./k8s-attach-manifest.yaml
#tmc cluster attach --name $custom_cluster_group --cluster-group $cluster_group
#echo

#kubectl apply -f ./k8s-attach-manifest.yaml
#echo


#CREATE GKE QUOTA CLUSTER
read -p "Attach GKE Quota Cluster"
echo

kubectl config use-context $quota_cluster
echo

rm ./k8s-attach-manifest.yaml
tmc cluster attach --name $quota_cluster --cluster-group $cluster_group
echo

kubectl apply -f ./k8s-attach-manifest.yaml
echo


#CREATE AKS SECURITY CLUSTER
#read -p "Attach AKS Security Cluster"
#echo

#kubectl config use-context $security_cluster_group
#echo

#rm ./k8s-attach-manifest.yaml
#tmc cluster attach --name $security_cluster_group --cluster-group $cluster_group
#echo

#kubectl apply -f ./k8s-attach-manifest.yaml
#echo

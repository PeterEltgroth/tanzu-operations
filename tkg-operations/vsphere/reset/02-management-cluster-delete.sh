read -p "Management Cluster Name: " mgmt_cluster_name

tanzu login

tanzu management-cluster delete

kubectl config delete-context ${mgmt_cluster_name}-admin@${mgmt_cluster_name}
kubectl config delete-cluster ${mgmt_cluster_name}
kubectl config delete-user ${mgmt_cluster_name}-admin

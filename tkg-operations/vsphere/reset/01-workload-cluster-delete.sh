read -p "Workload Cluster Name: " workload_cluster_name

tanzu login

tanzu cluster delete $workload_cluster_name

kubectl config delete-context ${workload_cluster_name}-admin@${workload_cluster_name}
kubectl config delete-cluster ${workload_cluster_name}
kubectl config delete-user ${workload_cluster_name}-admin

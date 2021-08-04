read -p "Management Cluster Name: " mgmt_cluster_name

tanzu management-cluster create $mgmt_cluster_name --ui --browser none

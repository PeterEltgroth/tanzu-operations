read -p "Management Cluster Name: " mgmt_cluster_name
read -p "Workload Cluster Name: " workload_cluster_name

cp .config/tanzu/tkg/clusterconfigs/${mgmt_cluster_name}.yaml .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml

tanzu cluster create $workload_cluster_name -f .config/tanzu/tkg/clusterconfigs/${workload_cluster_name}.yaml --plan dev

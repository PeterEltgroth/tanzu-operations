read -p "Management Cluster Name: " mgmt_cluster_name

tanzu management-cluster create $mgmt_cluster_name --ui --browser none


ls .config/tanzu/tkg/clusterconfigs

read -p "Cluster Config: " filename
read -p "New Cluster Config: " new_filename

mv .config/tanzu/tkg/clusterconfigs/$filename .config/tanzu/tkg/clusterconfigs/$new_filename
read -p "Management Cluster Name: " mgmt_cluster_name

tanzu management-cluster create $mgmt_cluster_name --ui --browser none


ls .tanzu/tkg/clusterconfigs

read -p "Cluster Config: " filename
read -p "New Cluster Config: " new_filename

mv .tanzu/tkg/clusterconfigs/$filename .tanzu/tkg/clusterconfigs/$new_filename
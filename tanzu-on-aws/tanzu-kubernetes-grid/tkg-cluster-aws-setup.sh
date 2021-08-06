ls .tanzu/tkg/clusterconfigs

read -p "Cluster Config: " filename
read -p "New Cluster Config: " new_filename

rm .tanzu/tkg/clusterconfigs/$new_filename
mv .tanzu/tkg/clusterconfigs/$filename .tanzu/tkg/clusterconfigs/$new_filename

tanzu login

read -p "Cluster 1: " cluster1

tanzu cluster $cluster1 -f .tanzu/tkg/clusterconfigs/$new_filename --plan dev
tanzu cluster kubeconfig get $cluster1 --admin

read -p "Cluster 2: " cluster2

tanzu cluster create $cluster2 -f .tanzu/tkg/clusterconfigs/$new_filename --plan dev
tanzu cluster kubeconfig get $cluster2 --admin

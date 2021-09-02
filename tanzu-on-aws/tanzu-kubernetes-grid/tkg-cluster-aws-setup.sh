tanzu login

read -p "Cluster 1: " cluster1

tanzu cluster create $cluster1 -f .tanzu/tkg/clusterconfigs/${new_filename}.yaml --plan dev
tanzu cluster kubeconfig get $cluster1 --admin


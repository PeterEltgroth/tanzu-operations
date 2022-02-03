#COPY MGMT CLUSTER KUBE CONFIG FROM TKG OPERATOR
#COPY AN EXISTING WORKLOAD CLUSTER SETUP FILE FROM .config/tanzu/tkg/clusterconfigs

read -p "Cluster Name: " cluster_name

tanzu cluster create $cluster_name -f .config/tanzu/tkg/clusterconfigs/${cluster_name}.yaml --plan dev

tanzu cluster kubeconfig get $cluster_name --admin

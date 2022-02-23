read -p "Cluster Name: " cluster_name

kubectl config use-context $cluster_name

kapp delete -a tanzu-build-service
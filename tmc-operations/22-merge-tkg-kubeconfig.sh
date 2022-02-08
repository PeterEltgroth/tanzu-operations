read -p "Cluster Name: " cluster_name


tmc cluster auth kubeconfig get $cluster_name --management-cluster-name aws-hosted --provisioner-name tmc-aws-provisioner



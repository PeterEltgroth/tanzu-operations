kubectl config use-context tmc-development-cluster
kubectl delete --ignore-not-found=true -f https://prod-2.nsxservicemesh.vmware.com/cluster-registration/k8s/client-cluster-uninstall.yaml

kubectl config use-context tmc-staging-cluster
kubectl delete --ignore-not-found=true -f https://prod-2.nsxservicemesh.vmware.com/cluster-registration/k8s/client-cluster-uninstall.yaml

kubectl config use-context tmc-production-cluster
kubectl delete --ignore-not-found=true -f https://prod-2.nsxservicemesh.vmware.com/cluster-registration/k8s/client-cluster-uninstall.yaml
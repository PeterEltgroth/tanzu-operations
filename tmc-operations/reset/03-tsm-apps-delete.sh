#WEB FRONTEND
kubectl config use-context tmc-staging-cluster
kubectl delete -f acme-fitness-demo/istio-manifests/gateway.yaml
kubectl delete -f acme-fitness-demo/kubernetes-manifests/secrets.yaml
kubectl delete -f acme-fitness-demo/kubernetes-manifests/acme_fitness_cluster1.yaml

kubectl delete service istio-ingressgateway -n istio-system


#CATALOG SERVICE
kubectl config use-context tmc-production-cluster
kubectl delete -f acme-fitness-demo/istio-manifests/gateway.yaml
kubectl delete -f acme-fitness-demo/kubernetes-manifests/secrets.yaml
kubectl delete -f acme-fitness-demo/kubernetes-manifests/acme_fitness_cluster2.yaml

git clone https://github.com/nycpivot/acme-fitness-demo.git

#WEB FRONTEND
kubectl config use-context nyc-fitness-web
kubectl apply -f acme_fitness_demo/istio-manifests/gateway.yaml
kubectl apply -f acme_fitness_demo/kubernetes-manifests/secrets.yaml
kubectl apply -f acme_fitness_demo/kubernetes-manifests/acme_fitness_cluster1.yaml

watch kubectl get pods

kubectl get services -n istio-system | grep istio-ingressgateway


#CATALOG SERVICE
kubectl config use-context nyc-fitness-catalog
kubectl apply -f acme_fitness_demo/istio-manifests/gateway.yaml
kubectl apply -f acme_fitness_demo/kubernetes-manifests/secrets.yaml
kubectl apply -f acme_fitness_demo/kubernetes-manifests/acme_fitness_cluster2.yaml

watch kubectl get pods





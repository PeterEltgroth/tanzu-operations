#ATTACH PROD CLUSTER
rm ./k8s-attach-manifest.yaml
tmc cluster attach --name tanzu-cluster-nginx-prod-eu-west-1 --cluster-group production

kubectl config use-context tanzu-cluster-nginx-prod-eu-west-1-admin@tanzu-cluster-nginx-prod-eu-west-1
kubectl apply -f ./k8s-attach-manifest.yaml

tmc cluster namespace create -f tmc/namespace-spring-web-prod.yaml
tmc cluster namespace create -f tmc/namespace-spring-app-prod.yaml
tmc cluster namespace create -f tmc/namespace-spring-data-prod.yaml

tmc workspace image-policy create -f tmc/registry-policy.yaml" # -i --dry-run


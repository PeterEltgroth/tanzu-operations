tmc login

#ATTACH DEV CLUSTER
rm ./k8s-attach-manifest.yaml
tmc cluster attach --name tanzu-aws-nginx-dev --cluster-group development

kubectl config use-context tanzu-aws-nginx-dev-admin@tanzu-aws-nginx-dev
kubectl apply -f ./k8s-attach-manifest.yaml


#ATTACH PROD CLUSTER
rm ./k8s-attach-manifest.yaml
tmc cluster attach --name tanzu-aws-nginx-prod --cluster-group production

kubectl config use-context tanzu-aws-nginx-prod-admin@tanzu-aws-nginx-prod
kubectl apply -f ./k8s-attach-manifest.yaml
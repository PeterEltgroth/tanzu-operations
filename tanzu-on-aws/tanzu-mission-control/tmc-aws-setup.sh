#ATTACH PROD CLUSTER
#rm ./k8s-attach-manifest.yaml
#tmc cluster attach --name tanzu-aws-nginx-prod --cluster-group production

#kubectl config use-context tanzu-aws-nginx-prod-admin@tanzu-aws-nginx-prod
#kubectl apply -f ./k8s-attach-manifest.yaml
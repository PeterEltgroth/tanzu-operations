ls .tanzu/tkg/clusterconfigs

read -p "Management Cluster Config: " filename

rm .tanzu/tkg/clusterconfigs/aws-config.yaml
mv .tanzu/tkg/clusterconfigs/$filename .tanzu/tkg/clusterconfigs/aws-config.yaml

tanzu cluster create tanzu-aws-nginx-dev -f .tanzu/tkg/clusterconfigs/aws-config.yaml --plan dev
tanzu cluster kubeconfig get tanzu-aws-nginx-dev --admin

tanzu cluster create tanzu-aws-nginx-prod -f .tanzu/tkg/clusterconfigs/aws-config.yaml --plan dev
tanzu cluster kubeconfig get tanzu-aws-nginx-prod --admin

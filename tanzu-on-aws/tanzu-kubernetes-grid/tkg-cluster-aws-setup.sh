tanzu cluster create tanzu-aws-nginx-dev -f .tanzu/tkg/clusterconfigs/aws-config.yaml
tanzu cluster kubeconfig get tanzu-aws-nginx-dev

tanzu cluster create tanzu-aws-nginx-prod -f .tanzu/tkg/clusterconfigs/aws-config.yaml
tanzu cluster kubeconfig get tanzu-aws-nginx-prod

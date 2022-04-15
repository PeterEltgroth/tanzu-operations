kubectl config use-context tmc-development-cluster
velero backup create tmc-development-cluster-backup

kubectl config use-context tmc-staging-cluster
velero backup create tmc-staging-cluster-backup

kubectl config use-context tmc-production-cluster
velero backup create tmc-production-cluster-backup

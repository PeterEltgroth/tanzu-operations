kubectl config use-context tmc-development-cluster
velero restore create --from-backup tmc-development-cluster-backup

kubectl config use-context tmc-staging-cluster
velero restore create --from-backup tmc-staging-cluster-backup

kubectl config use-context tmc-production-cluster
velero restore create --from-backup tmc-production-cluster-backup

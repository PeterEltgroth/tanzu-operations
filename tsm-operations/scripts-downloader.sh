rm -rf tsm
mkdir tsm

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/01-operator-pre-reqs.sh -O tsm/01-operator-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/02-create-image-us-east-2.sh -O tsm/02-create-image-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/02-create-snapshot-us-east-2.sh -O tsm/02-create-snapshot-us-east-2.sh


#wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/10-aks-create-development.sh -O tmc/10-aks-create-development.sh
#wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/11-eks-create-staging.sh -O tmc/11-eks-create-staging.sh
#wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/12-gke-create-production.sh -O tmc/12-gke-create-production.sh
#wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/13-tanzu-management-cluster-setup.sh -O tmc/13-tanzu-management-cluster-setup.sh
#wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/14-tkg-create-build.sh -O tmc/14-tkg-create-build.sh



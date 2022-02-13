rm -rf tsm
mkdir tsm

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/01-operator-pre-reqs.sh -O tsm/01-operator-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/02-tanzu-install-v1.4.0.sh -O tsm/02-tanzu-install-v1.4.0.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/02-tanzu-install-v1.4.1.sh -O tsm/02-tanzu-install-v1.4.1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/03-image-create-us-east-2.sh -O tsm/03-image-create-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/03-snapshot-create-us-east-2.sh -O tsm/03-snapshot-create-us-east-2.sh


wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/10-aks-nyc-fitness-web-create.sh -O tsm/10-aks-nyc-fitness-web-create.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/11-gke-nyc-fitness-catalog-create.sh -O tsm/11-gke-nyc-fitness-catalog-create.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/12-tanzu-management-cluster-create.sh -O tsm/12-tanzu-management-cluster-create.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/13-tkg-nyc-fitness-catalog-create.sh -O tsm/13-tkg-nyc-fitness-catalog-create.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/20-cluster-onboard.sh -O tsm/20-cluster-onboard.sh

rm -rf tsm
mkdir tsm

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/01-operator-pre-reqs.sh -O tsm/01-operator-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/02-install-tanzu-v1.4.0.sh -O tsm/02-install-tanzu-v1.4.0.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/02-install-tanzu-v1.4.1.sh -O tsm/02-install-tanzu-v1.4.1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/03-create-image-us-east-2.sh -O tsm/03-create-image-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/03-create-snapshot-us-east-2.sh -O tsm/03-create-snapshot-us-east-2.sh


wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/10-aks-acme-fitness-web-create.sh -O tsm/10-aks-acme-fitness-web-create.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/11-gke-acme-fitness-catalog-create.sh -O tsm/11-gke-acme-fitness-catalog-create.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/12-tanzu-management-cluster-setup.sh -O tsm/12-tanzu-management-cluster-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tsm-operations/13-tkg-acme-fitness-catalog-create.sh -O tsm/13-tkg-acme-fitness-catalog-create.sh



rm -rf tkg
mkdir tkg

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/01-tkg-install-v1.5.1.sh -O tkg/01-tkg-install-v1.5.1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/02-create-image-us-east-2.sh -O tkg/02-create-image-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/02-create-snapshot-us-east-2.sh -O tkg/02-create-snapshot-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/03-tanzu-management-cluster-dev-setup.sh -O tkg/03-tanzu-management-cluster-dev-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/03-tanzu-management-cluster-setup-ui.sh -O tkg/03-tanzu-management-cluster-setup-ui.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/04-tanzu-workload-cluster-dev-create.sh -O tkg/04-tanzu-workload-cluster-dev-create.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/04-tanzu-workload-cluster-prod-create.sh -O tkg/04-tanzu-workload-cluster-prod-create.sh

mkdir tkg/reset

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/reset/01-workload-cluster-delete.sh -O tkg/reset/01-workload-cluster-delete.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/reset/02-management-cluster-delete.sh -O tkg/reset/02-management-cluster-delete.sh


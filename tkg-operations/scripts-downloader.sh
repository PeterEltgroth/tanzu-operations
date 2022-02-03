rm -rf tkg
mkdir tkg

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/01-operator-pre-reqs.sh -O tkg/01-operator-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/02-tanzu-management-cluster-setup-ui.sh -O tkg/02-tanzu-management-cluster-setup-ui.sh


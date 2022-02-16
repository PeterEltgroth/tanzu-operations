rm -rf tkg
mkdir tkg

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/01-operator-pre-reqs.sh -O tkg/01-operator-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/02-install-tanzu-v1.4.0.sh -O tkg/02-install-tanzu-v1.4.0.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/02-install-tanzu-v1.4.1.sh -O tkg/02-install-tanzu-v1.4.1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/03-tanzu-management-cluster-setup.sh -O tkg/03-tanzu-management-cluster-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/03-tanzu-management-cluster-setup-ui.sh -O tkg/03-tanzu-management-cluster-setup-ui.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-operations/04-tanzu-workload-cluster-create.sh -O tkg/04-tanzu-workload-cluster-create.sh




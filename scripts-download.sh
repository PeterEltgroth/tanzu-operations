wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/base-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tbs-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-management-cluster-aws-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-management-cluster-aws-setup-ui.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-cluster-aws-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-gitlab-registry.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-harbor-registry.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-mission-control/tmc-aws-setup.sh

mkdir operations-setup

mv base-setup.sh operations-setup/base-setup.sh
mv tkg-setup.sh operations-setup/tkg-setup.sh
mv tbs-setup.sh operations-setup/tbs-setup.sh
mv tmc-setup.sh operations-setup/tmc-setup.sh
mv tkg-management-cluster-aws-setup.sh operations-setup/tkg-management-cluster-aws-setup.sh
mv tkg-management-cluster-aws-setup-ui.sh operations-setup/tkg-management-cluster-aws-setup-ui.sh
mv tkg-cluster-aws-setup.sh operations-setup/tkg-cluster-aws-setup.sh
mv tbs-on-tkg-with-gitlab-registry.sh operations-setup/tbs-on-tkg-with-gitlab-registry.sh
mv tbs-on-tkg-with-harbor-registry.sh operations-setup/tbs-on-tkg-with-harbor-registry.sh
mv tmc-aws-setup.sh operations-setup/tmc-aws-setup.sh

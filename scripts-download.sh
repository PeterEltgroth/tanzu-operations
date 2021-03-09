wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/base-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-management-cluster-aws-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-gitlab-registry.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-harbor-registry.sh

mkdir operations-setup

mv base-setup.sh operations-setup/base-setup.sh
mv tkg-management-cluster-aws-setup.sh operations-setup/tkg-management-cluster-aws-setup.sh
mv tbs-on-tkg-with-gitlab-registry.sh operations-setup/tbs-on-tkg-with-gitlab-registry.sh
mv tbs-on-tkg-with-harbor-registry.sh operations-setup/tbs-on-tkg-with-harbor-registry.sh

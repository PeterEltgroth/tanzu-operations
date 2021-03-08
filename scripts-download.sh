wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/base-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-aws-management-cluster-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-gitlab-registry.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-harbor-registry.sh

mkdir operations-setup

mv base-setup.sh operations-setup/base-setup.sh
mv tkg-aws-management-cluster-setup.sh operations-setup/tkg-aws-management-cluster-setup.sh
mv tbs-on-tkg-with-gitlab-registry.sh operations-setup/tbs-on-tkg-with-gitlab-registry.sh
mv tbs-on-tkg-with-harbor-registry.sh operations-setup/tbs-on-tkg-with-harbor-registry.sh

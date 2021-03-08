wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/base-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-aws-management-cluster-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-gitlab-registry.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-harbor-registry.sh

mkdir scripts

mv base-setup.sh scripts/base-setup.sh
mv tkg-aws-management-cluster-setup.sh scripts/tkg-aws-management-cluster-setup.sh
mv tbs-on-tkg-with-gitlab-registry.sh scripts/tbs-on-tkg-with-gitlab-registry.sh
mv tbs-on-tkg-with-harbor-registry.sh scripts/tbs-on-tkg-with-harbor-registry.sh

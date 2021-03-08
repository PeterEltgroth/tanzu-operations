wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/base-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-aws-management-cluster-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-gitlab-registry.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-harbor-registry.sh

mkdir operations

mv base-setup.sh operations/base-setup.sh
mv tkg-aws-management-cluster-setup.sh operations/tkg-aws-management-cluster-setup.sh
mv tbs-on-tkg-with-gitlab-registry.sh operations/tbs-on-tkg-with-gitlab-registry.sh
mv tbs-on-tkg-with-harbor-registry.sh operations/tbs-on-tkg-with-harbor-registry.sh

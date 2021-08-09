mkdir operations-setup
mkdir tmc
mkdir deploy

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/base-setup.sh -O operations-setup/base-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tkg-setup.sh -O operations-setup/tkg-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tbs-setup.sh -O operations-setup/tbs-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-setup.sh -O operations-setup/tmc-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-management-cluster-aws-setup.sh -O operations-setup/tkg-management-cluster-aws-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-management-cluster-aws-setup-ui.sh -O operations-setup/tkg-management-cluster-aws-setup-ui.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-kubernetes-grid/tkg-cluster-aws-setup.sh -O operations-setup/tkg-cluster-aws-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-gitlab-registry.sh -O operations-setup/tbs-on-tkg-with-gitlab-registry.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-build-service/tbs-on-tkg-with-harbor-registry.sh -O operations-setup/tbs-on-tkg-with-harbor-registry.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-on-aws/tanzu-mission-control/tmc-aws-setup.sh -O operations-setup/tmc-aws-setup.sh


wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/reset.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/demo-live.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/namespace-spring-app-dev.yaml -O tmc/namespace-spring-app-dev.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/namespace-spring-data-dev.yaml -O tmc/namespace-spring-data-dev.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/namespace-spring-web-dev.yaml -O tmc/namespace-spring-web-dev.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/namespace-spring-app-prod.yaml -O tmc/namespace-spring-app-prod.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/namespace-spring-data-prod.yaml -O tmc/namespace-spring-data-prod.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/namespace-spring-web-prod.yaml -O tmc/namespace-spring-web-prod.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/network-database-policy.yaml -O tmc/network-database-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/quota-development-policy.yaml -O tmc/quota-development-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/registry-policy.yaml -O tmc/registry-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/tmc/security-production-policy.yaml -O tmc/security-production-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-amazon/main/tanzu-advanced-in-depth/deploy/deployment-spring-music-quota.yaml -O deploy/deployment-spring-music-quota.yaml

rm -rf tmc
mkdir tmc

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/01-operator-pre-reqs.sh -O tmc/01-operator-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/02-create-image-us-east-2.sh -O tmc/02-create-image-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/02-create-snapshot-us-east-2.sh -O tmc/02-create-snapshot-us-east-2.sh


wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/10-aks-create-development.sh -O tmc/10-aks-create-development.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/11-eks-create-staging.sh -O tmc/11-eks-create-staging.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/12-gke-create-production.sh -O tmc/12-gke-create-production.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/13-tanzu-management-cluster-setup.sh -O tmc/13-tanzu-management-cluster-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/14-tkg-create-build.sh -O tmc/14-tkg-create-build.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/20-attach-clusters.sh -O tmc/20-attach-clusters.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/21-provision-clusters.sh -O tmc/21-provision-clusters.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/30-demo-pre-reqs.sh -O tmc/30-demo-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/31-demo-quota-policy-tkg.sh -O tmc/31-demo-quota-policy-tkg.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/32-demo-quota-policy-aks.sh -O tmc/32-demo-quota-policy-aks.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/33-demo-security-policy.sh -O tmc/33-demo-security-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/34-demo-registry-policy.sh -O tmc/34-demo-registry-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/35-demo-network-policy.sh -O tmc/35-demo-network-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/36-demo-access-policy.sh -O tmc/36-demo-access-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/37-demo-custom-policy.sh -O tmc/37-demo-custom-policy.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/40-install-wavefront.sh -O tmc/40-install-wavefront.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/41-demo-tos-integration-k8s.sh -O tmc/41-demo-tos-integration-k8s.sh


mkdir tmc/reset

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/reset/01-delete-tmc.sh -O tmc/reset/01-delete-tmc.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/reset/02-aks-delete.sh -O tmc/reset/02-aks-delete.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/reset/03-eks-delete.sh -O tmc/reset/03-eks-delete.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/reset/04-gke-delete.sh -O tmc/reset/04-gke-delete.sh


mkdir tmc/configs

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/namespace-web.yaml -O tmc/configs/namespace-web.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/namespace-api.yaml -O tmc/configs/namespace-api.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/namespace-app.yaml -O tmc/configs/namespace-app.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/namespace-data.yaml -O tmc/configs/namespace-data.yaml

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/network-policy.yaml -O tmc/configs/network-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/quota-exceeds.yaml -O tmc/configs/quota-exceeds.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/quota-policy.yaml -O tmc/configs/quota-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/quota-within.yaml -O tmc/configs/quota-within.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/registry-namespace.yaml -O tmc/configs/registry-namespace.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/registry-policy.yaml -O tmc/configs/registry-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/security-policy.yaml -O tmc/configs/security-policy.yaml

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/tos-node-stressor.yaml -O tmc/configs/tos-node-stressor.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/tos-cluster-stressor.yaml -O tmc/configs/tos-cluster-stressor.yaml

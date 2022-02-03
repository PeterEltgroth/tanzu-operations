rm -rf tmc
mkdir tmc

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/01-operator-pre-reqs.sh -O tmc/01-operator-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/02-create-image-us-east-2.sh -O tmc/02-create-image-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/02-create-snapshot-us-east-2.sh -O tmc/02-create-snapshot-us-east-2.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/10-aks-setup-development.sh -O tmc/10-aks-setup-development.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/11-tkg-setup-build.sh -O tmc/11-tkg-setup-build.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/12-eks-setup-staging.sh -O tmc/12-eks-setup-staging.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/13-gke-setup-production.sh -O tmc/13-gke-setup-production.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/20-attach-clusters.sh -O tmc/20-attach-clusters.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/21-install-wavefront.sh -O tmc/21-install-wavefront.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/100-demo-pre-reqs.sh -O tmc/100-demo-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/101-demo-security-policy.sh -O tmc/101-demo-security-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/102-demo-quota-policy-gke.sh -O tmc/102-demo-quota-policy-gke.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/103-demo-quota-policy-aks.sh -O tmc/103-demo-quota-policy-aks.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/104-demo-registry-policy.sh -O tmc/104-demo-registry-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/105-demo-network-policy.sh -O tmc/105-demo-network-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/106-demo-access-policy.sh -O tmc/106-demo-access-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/107-demo-custom-policy.sh -O tmc/107-demo-custom-policy.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/500-demo-tos-integration-k8s.sh -O tmc/500-demo-tos-integration-k8s.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/reset/01-delete-tmc.sh -O tmc/reset/01-delete-tmc.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/reset/02-aks-delete.sh -O tmc/reset/02-aks-delete.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/reset/03-eks-delete.sh -O tmc/reset/03-eks-delete.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/reset/04-gke-delete.sh -O tmc/reset/04-gke-delete.sh


mkdir tmc/configs

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/network-namespace.yaml -O tmc/configs/network-namespace.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/network-policy.yaml -O tmc/configs/network-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/quota-exceeds.yaml -O tmc/configs/quota-exceeds.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/quota-policy.yaml -O tmc/configs/quota-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/quota-within.yaml -O tmc/configs/quota-within.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/registry-namespace.yaml -O tmc/configs/registry-namespace.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/registry-policy.yaml -O tmc/configs/registry-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/security-policy.yaml -O tmc/configs/security-policy.yaml

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/tos-node-stressor.yaml -O tmc/configs/tos-node-stressor.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/tos-cluster-stressor.yaml -O tmc/configs/tos-cluster-stressor.yaml

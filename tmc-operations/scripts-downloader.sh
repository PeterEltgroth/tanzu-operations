rm -rf tmc
mkdir tmc

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/01-bootstrapper-setup.sh -O tmc/01-bootstrapper-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/02-tmc-operator-creator.sh -O tmc/02-tmc-operator-creator.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/10-pre-reqs.sh -O tmc/10-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/11-eks-setup-us-west-1.sh -O tmc/11-eks-setup-us-west-1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/12-aks-setup-tanzu-operations.sh -O tmc/12-aks-setup-tanzu-operations.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/13-gke-setup-us-east1.sh -O tmc/13-gke-setup-us-east1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/20-tmc-setup.sh -O tmc/20-tmc-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/100-demo-pre-reqs-workspace.sh -O tmc/100-demo-pre-reqs-workspace.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/101-demo-registry-policy.sh -O tmc/101-demo-registry-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/102-demo-registry-policy.sh -O tmc/102-demo-registry-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/103-demo-network-policy.sh -O tmc/103-demo-network-policy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/104-demo-access-policy.sh -O tmc/104-demo-access-policy.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/1000-delete-tmc.sh -O tmc/1000-delete-tmc.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/1001-delete-clusters.sh -O tmc/1001-delete-clusters.sh

mkdir tmc/configs

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/deployment-exceeds-quota.yaml -O tmc/configs/deployment-exceeds-quota.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/network-namespace.yaml -O tmc/configs/network-namespace.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/network-policy.yaml -O tmc/configs/network-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/quota-policy.yaml -O tmc/configs/quota-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/registry-namespace.yaml -O tmc/configs/registry-namespace.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/registry-policy.yaml -O tmc/configs/registry-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/security-policy.yaml -O tmc/configs/security-policy.yaml


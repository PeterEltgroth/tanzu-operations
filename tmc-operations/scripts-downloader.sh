rm -rf tmc
mkdir tmc

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/00-delete-tmc.sh -O tmc/00-delete-tmc.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/01-delete-clusters.sh -O tmc/01-delete-clusters.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/10-pre-reqs.sh -O tmc/10-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/11-eks-setup-ap-northeast-1.sh -O tmc/11-eks-setup-ap-northeast-1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/12-aks-setup-tanzu-operations.sh -O tmc/12-aks-setup-tanzu-operations.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/13-gke-setup-us-east1.sh -O tmc/13-gke-setup-us-east1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/20-tmc-setup.sh -O tmc/20-tmc-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/100-demo-registry-and-network.sh -O tmc/100-demo-registry-and-network.sh

mkdir tmc/configs

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/registry-namespace.yaml -O tmc/configs/registry-namespace.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/registry-policy.yaml -O tmc/configs/registry-policy.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/network-namespace.yaml -O tmc/configs/network-namespace.yaml
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/configs/network-policy.yaml -O tmc/configs/network-policy.yaml

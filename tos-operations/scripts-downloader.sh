rm -rf tos
mkdir tos

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/10-pre-reqs.sh -O tos/10-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/11-eks-setup-us-east-1.sh -O tos/11-eks-setup-us-east-1.sh


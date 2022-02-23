rm -rf tbs
mkdir tbs

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tbs-operations/01-operator-pre-reqs.sh -O tbs/01-operator-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tbs-operations/02-tbs-prereqs-v1.4.sh -O tbs/02-tbs-prereqs-v1.4.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tbs-operations/03-tbs-install-v1.4.sh -O tbs/03-tbs-install-v1.4.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tbs-operations/04-kp-secrets-create.sh -O tbs/04-kp-secrets-create.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tbs-operations/100-demo-image-create.sh -O tbs/100-demo-image-create.sh



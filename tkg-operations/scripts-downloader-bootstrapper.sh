rm -rf tmc
mkdir tmc

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/bootstrap/bootstrapper-setup.sh -O bootstrapper-setup.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/bootstrap/tmc-operator-from-new-us-east-2.sh -O tmc-operator-from-new-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/bootstrap/tmc-operator-from-new-us-west-1.sh -O tmc-operator-from-new-us-west-1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/bootstrap/tmc-operator-from-image-us-east-2.sh -O tmc-operator-from-image-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tmc-operations/bootstrap/tmc-operator-from-snapshot-us-east-2.sh -O tmc-operator-from-snapshot-us-east-2.sh

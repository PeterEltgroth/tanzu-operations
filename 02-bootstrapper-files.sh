#!bin/bash

rm operator-bootstrapper.sh
cat <<EOF | tee operator-bootstrapper.sh
read -p "Operator Prefix: " operator_prefix

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/10-operator-prereqs.sh -O 01-operator-prereqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/11-image-create-us-east-2.sh -O 02-image-create-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/11-snapshot-create-us-east-2.sh -O 02-snapshot-create-us-east-2.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/\${operator_prefix}-operations/scripts-bootstrapper.sh
EOF
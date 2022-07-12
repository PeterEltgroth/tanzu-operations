#!bin/bash

rm operator-bootstrapper.sh
cat <<EOF | tee operator-bootstrapper.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/10-operator-prereqs.sh -O 01-operator-prereqs.sh
EOF
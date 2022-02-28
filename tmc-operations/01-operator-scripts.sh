read -p "Operator Prefix: " operator_prefix

#DOWNLOAD OPERATOR SCRIPTS
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/${operator_prefix}-operations/scripts-bootstrapper.sh

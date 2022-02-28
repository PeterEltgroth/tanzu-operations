read -p "Operator Prefix: " operator_prefix

prereqs=$(cat user-data | jq .prereqs)
scripts=$(cat user-data | jq .${operator_prefix})

#DOWNLOAD OPERATOR SCRIPTS
wget prereqs
wget scripts

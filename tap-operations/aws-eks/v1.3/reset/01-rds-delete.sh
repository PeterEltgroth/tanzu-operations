read -p "RDS Instance Name: " rds_instance

tanzu package installed delete $rds_instance -n default
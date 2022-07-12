read -p "Operator Name: " operator_name
read -p "Snapshot Name: " snapshot_name
read -p "AWS Region Code (us-east-2): " aws_region_code

aws lightsail create-instances-from-snapshot \
    --instance-snapshot-name $snapshot_name \
    --instance-names $operator_name \
    --availability-zone $aws_region_code \
    --bundle-id medium_2_0

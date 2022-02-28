read -p "Operator Name: " operator_name
read -p "Image Name: " image_name
read -p "AWS Region Code: " aws_region_code

aws s3 cp s3://vmware-tanzu-operations/${operator_name}-${aws_region_code} ./
instance_id=$(cat ${operator_name}-${aws_region_code})

aws ec2 create-image --instance-id $instance_id --name "${image_name}-${aws_region_code}" --no-reboot

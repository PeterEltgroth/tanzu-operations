read -p "AWS Region Code: " aws_region_code

tap_operator=tap-operator-${aws_region_code}
tap_operator_image=tap-operator-imsage-${aws_region_code}
key_name="ResourceType=instance,Tags=[{Key=Name,Value="${tap_operator_image}"}]"

aws s3 cp s3://vmware-tanzu-operations/${tap_operator} ./
instance_id=$(cat ${tap_operator})

aws ec2 create-image --instance-id $instance_id --name "${tap_operator_image}" --no-reboot \
	--tag-specifications "${key_name}"

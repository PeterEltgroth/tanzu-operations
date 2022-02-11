read -p "Operator Name: " operator_name

aws s3 cp s3://vmware-tanzu-operations/${operator_name} ./
instance_id=$(cat $operator_name)

aws ec2 create-image --instance-id $instance_id --name "tmc-operator-image-us-east-2" --no-reboot \
	--tag-specifications 'ResourceType=image,Tags=[{Key=Name,Value=tmc-operator-image-us-east-2}]'

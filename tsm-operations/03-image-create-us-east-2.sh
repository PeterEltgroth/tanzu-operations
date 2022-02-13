read -p "Operator Name: " operator_name
read -p "Image Name: " image_name
read -p "AWS Region Code (us-east-2): " aws_region_code

if [[ -z $aws_region_code ]]
then
	aws_region_code=us-east-2
fi

aws s3 cp s3://vmware-tanzu-operations/${operator_name}-${aws_region_code} ./
instance_id=$(cat ${operator_name}-${aws_region_code})

aws ec2 create-image --instance-id $instance_id --name "${image_name}-${aws_region_code}" --no-reboot
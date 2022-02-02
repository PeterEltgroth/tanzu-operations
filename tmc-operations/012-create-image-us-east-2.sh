aws s3 cp s3://tmc-operations/operator-instance.txt ./
instance_id=$(cat operator-instance.txt)

aws ec2 create-image --instance-id $instance_id --name "tmc-operator-image-us-east-2" --no-reboot \
	--tag-specifications 'ResourceType=image,Tags=[{Key=Name,Value=tmc-operator-image-us-east-2}]'

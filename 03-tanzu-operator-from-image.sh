read -p "Operator Name: " operator_name
read -p "AWS Region Code: " aws_region_code

aws ec2 describe-images --region $aws_region_code --owners self --output text --query 'Images[*].[ImageId]'

read -p "Input image: " image_id

instance_id=''
operator_name=${operator_name}-${aws_region_code}
key_name="ResourceType=instance,Tags=[{Key=Name,Value="${operator_name}"}]"

export AWS_REGION=$aws_region_code

if [[ $aws_region_code = "us-east-2" ]]
then
	instance_id=$(aws ec2 run-instances --image-id $image_id --instance-type t3.large --block-device-mappings '{"DeviceName": "/dev/sda1", "Ebs": {"DeleteOnTermination": true, "VolumeSize": 200}}' --tag-specifications "${key_name}" --security-group-ids tanzu-operations-${aws_region_code} --key-name tanzu-operations-${aws_region_code} --output text --query "Instances[0].InstanceId")
fi
#elif [[ $aws_region_code = "us-west-1" ]]
#then
	#DO NOT USE SPOT INSTANCE TYPE PERSISTENT, NEW ONES WILL LAUNCH EVERY TIME THEY ARE TERMINATED
	#instance_id=$(aws ec2 run-instances --image-id $image_id --instance-type t3.large --block-device-mappings '{"DeviceName": "/dev/sda1", "Ebs": {"DeleteOnTermination": true, "VolumeSize": 200}}' --instance-market-options '{"MarketType": "spot", "SpotOptions": {"SpotInstanceType": "persistent", "InstanceInterruptionBehavior": "stop", "ValidUntil": "2030-12-31 T11:59:59"}}' --tag-specifications "${key_name}" --security-group-ids tanzu-operations-${aws_region_code} --key-name tanzu-operations-${aws_region_code} --output text --query "Instances[0].InstanceId")
#fi

public_dns=$(aws ec2 describe-instances --instance-ids $instance_id | jq "[.Reservations[].Instances[] | { PublicDnsName }]")
dns=$(eval "echo \${public_dns} | jq '.[] | .PublicDnsName'" | tr -d '"')

aws s3 rm s3://vmware-tanzu-operations/${operator_name} --recursive
echo $instance_id | aws s3 cp - s3://vmware-tanzu-operations/${operator_name}
echo

echo
echo "OPERATOR DNS:"
echo $dns
echo

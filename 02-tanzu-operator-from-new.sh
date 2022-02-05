read -p "Operator Name: " operator_name
read -p "AWS Region Code: " aws_region_code
read -p "Initializer Url: " initializer_url

instance_id=''
operator_name=${operator_name}-${aws_region_code}
key_name="ResourceType=instance,Tags=[{Key=Name,Value="${operator_name}"}]"

if [[ $aws_region_code = "us-east-2" ]]
then
    instance_id=$(aws ec2 run-instances --image-id ami-0fb653ca2d3203ac1 --instance-type t3a.2xlarge --block-device-mappings '{"DeviceName": "/dev/sda1", "Ebs": {"DeleteOnTermination": true, "VolumeSize": 500}}' --tag-specifications "${key_name}" --security-group-ids tanzu-operations-${aws_region_code} --key-name tanzu-operations-${aws_region_code} --user-data "${initializer_url}" --output text --query "Instances[0].InstanceId")
else
	instance_id=$(aws ec2 run-instances --image-id ami-01f87c43e618bf8f0 --instance-type t3a.2xlarge --block-device-mappings '{"DeviceName": "/dev/sda1", "Ebs": {"DeleteOnTermination": true, "VolumeSize": 500}}' --tag-specifications "${key_name}" --security-group-ids tanzu-operations-${aws_region_code} --key-name tanzu-operations-${aws_region_code} --user-data "${initializer_url}" --output text --query "Instances[0].InstanceId")
fi

public_dns=$(aws ec2 describe-instances --instance-ids $instance_id | jq "[.Reservations[].Instances[] | { PublicDnsName }]")
dns=$(eval "echo \${public_dns} | jq '.[] | .PublicDnsName'" | tr -d '"')

#aws s3 rm s3://tmc-operations/operator-instance-us-east-2.txt --recursive
#echo $instance_id | aws s3 cp - s3://tmc-operations/operator-instance-us-east-2.txt
#echo

echo "Operator Dns: " $dns
echo
echo "User Data: http://169.254.169.254/latest/user-data"
echo

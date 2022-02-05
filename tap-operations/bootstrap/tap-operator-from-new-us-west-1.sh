instance_id=$(aws ec2 run-instances --image-id ami-01f87c43e618bf8f0 --instance-type t3a.2xlarge --block-device-mappings '{"DeviceName": "/dev/sda1", "Ebs": {"DeleteOnTermination": true, "VolumeSize": 500}}' --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=tap-operator-us-west-1}]' --security-group-ids tanzu-operations-us-west-1 --key-name tanzu-operations-us-west-1 --user-data 'https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tap-operations/scripts-initializer.sh' --output text --query "Instances[0].InstanceId")

public_dns=$(aws ec2 describe-instances --instance-ids $instance_id | jq "[.Reservations[].Instances[] | { PublicDnsName }]")

dns=$(eval "echo \${public_dns} | jq '.[] | .PublicDnsName'" | tr -d '"')

#aws s3 rm s3://tmc-operations/operator-instance-us-west-1.txt --recursive
#echo $instance_id | aws s3 cp - s3://tmc-operations/operator-instance-us-west-1.txt
#echo

echo "Operator Dns: " $dns
echo
echo "User Data: http://169.254.169.254/latest/user-data"
echo

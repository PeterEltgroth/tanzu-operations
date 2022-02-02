#GET INSTANCE ID SAVED TO S3 FROM PRE-REQS SCRIPTS
aws s3 cp s3://tmc-operations/operator-instance.txt ./
instance_id=$(cat operator-instance.txt)

ebs_volume_id=$(aws ec2 describe-instances --instance-ids $instance_id | jq '[.Reservations[].Instances[] | (.BlockDeviceMappings[] | { VolumeId: .Ebs.VolumeId })]')
volume_id=$(eval "echo \${ebs_volume_id} | jq '.[] | .VolumeId'" | tr -d '"')

aws ec2 create-snapshot --volume-id $volume_id --tag-specifications 'ResourceType=snapshot,Tags=[{Key=Name,Value=tmc-operator-snapshot-us-east-2}]'

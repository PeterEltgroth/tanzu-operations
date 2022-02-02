volume_id=$(cat volume-id.txt)

aws ec2 create-snapshot --volume-id $volume_id --tag-specifications 'ResourceType=snapshot,Tags=[{Key=Name,Value=tmc-operator-snapshot-us-east-2}]'

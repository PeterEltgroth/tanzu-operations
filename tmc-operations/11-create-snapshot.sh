volume_id=$(cat volume-id.txt)

aws ec2 create-snapshot --volume-id $volume_id

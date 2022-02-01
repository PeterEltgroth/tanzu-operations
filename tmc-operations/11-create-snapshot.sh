volume_id=$(cat volume.id)

aws ec2 create-snapshot --volume-id $volume_id

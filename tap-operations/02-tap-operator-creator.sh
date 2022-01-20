aws ec2 run-instances \
        --image-id ami-088da9557aae42f39 \
        --instance-type t3a.2xlarge \
        --block-device-mappings '{"DeviceName": "/dev/sda1", "Ebs": {"DeleteOnTermination": true, "VolumeSize": 500}}' \
        --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=tmc-operator-ap-northeast-1}]' \
        --security-group-ids tmc-operator-ap-northeast-1 \
        --key-name tmc-operator-ap-northeast-1

aws ec2 run-instances \
        --image-id ami-04505e74c0741db8d \
        --instance-type t3a.2xlarge \
        --block-device-mappings '{"DeviceName": "/dev/sda1", "Ebs": {"DeleteOnTermination": true, "VolumeSize": 500}}' \
        --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=tos-operator-us-east-1}]' \
        --security-group-ids tanzu-operator-us-east-1 \
        --key-name tanzu-operations-us-east-1

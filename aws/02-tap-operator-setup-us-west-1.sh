aws ec2 run-instances \
	--image-id ami-01f87c43e618bf8f0 \
	--instance-type t3a.2xlarge \
	--block-device-mappings '{"DeviceName": "/dev/sda1", "Ebs": {"DeleteOnTermination": true, "VolumeSize": 500}}' \
	--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=tanzu-application-operator-us-west-1}]' \
	--security-group-ids ssh-us-west-1 \
	--key-name tanzu-bootstrapper-us-west-1
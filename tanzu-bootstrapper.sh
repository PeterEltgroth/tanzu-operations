read -p "AWS Region Code: " aws_region_code

if [[ $aws_region_code = "us-east-2" ]]
then
    ssh ubuntu@ec2-18-189-32-145.us-east-2.compute.amazonaws.com -i keys/tanzu-operations-${aws_region_code}.pem
else
	ssh ubuntu@ec2-54-219-181-173.us-west-1.compute.amazonaws.com -i keys/tanzu-operations-${aws_region_code}.pem
fi

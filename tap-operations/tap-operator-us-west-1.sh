read -p "AWS Region Code (us-west-1): " aws_region_code

if [[ -z $aws_region_code ]]
then
    aws_region_code=us-west-1
fi

if [[ $aws_region_code = "us-west-1" ]]
then
    ssh ubuntu@ec2-3-142-97-83.us-east-2.compute.amazonaws.com -i ../keys/tanzu-operations-${aws_region_code}.pem
fi

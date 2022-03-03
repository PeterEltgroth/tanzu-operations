read -p "AWS Region Code (us-east-2): " aws_region_code

if [[ -z $aws_region_code ]]
then
    aws_region_code=us-east-2
fi

if [[ $aws_region_code = "us-east-2" ]]
then
    ssh ubuntu@ec2-18-223-15-38.us-east-2.compute.amazonaws.com -i ../keys/tanzu-operations-${aws_region_code}.pem -L 8080:localhost:8080
fi

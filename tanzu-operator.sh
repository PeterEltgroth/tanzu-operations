read -p "AWS Region Code (us-east-1): " aws_region_code

if [[ -z $aws_region_code ]]
then
    aws_region_code=us-east-1
fi

if [[ $aws_region_code = "us-east-1" ]]
then
    ssh ubuntu@ec2-3-239-5-189.compute-1.amazonaws.com -i keys/tanzu-operations-${aws_region_code}.pem -L 8080:localhost:8080
fi

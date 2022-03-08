read -p "AWS Region Code (us-east-2): " aws_region_code

if [[ -z $aws_region_code ]]
then
    aws_region_code=us-east-2
fi

if [[ $aws_region_code = "us-east-2" ]]
then
    ssh ubuntu@ec2-18-188-130-0.us-east-2.compute.amazonaws.com -i ../keys/tanzu-operations-${aws_region_code}.pem -L 8080:localhost:8080 -L 8081:localhost:8081 -L 8082:localhost:8082 -L 16686:localhost:16686
fi

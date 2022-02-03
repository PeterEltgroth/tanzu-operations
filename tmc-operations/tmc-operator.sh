read -p "AWS Region Code (us-east-2): " aws_region_code

if [ -z $aws_region_code ]
then
    aws_region_code=us-east-2
fi

if [ $aws_region_code = "us-east-2"]
then
    ssh ubuntu@ec2-54-165-214-7.compute-1.amazonaws.com -i keys/aws-operator-us-east-1.pem
fi
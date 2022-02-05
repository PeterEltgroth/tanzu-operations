read -p "AWS Region Code: " aws_region_code

if [[ $aws_region_code = "us-west-1" ]]
then
    ssh ubuntu@ec2-13-56-189-67.us-west-1.compute.amazonaws.com -i ../keys/tanzu-operations-${aws_region_code}.pem
fi

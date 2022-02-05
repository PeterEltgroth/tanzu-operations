read -p "AWS Region Code: " aws_region_code

if [[ $aws_region_code = "us-west-1" ]]
then
    ssh ubuntu@ec2-54-176-237-249.us-west-1.compute.amazonaws.com -i ../keys/tanzu-operations-${aws_region_code}.pem
fi

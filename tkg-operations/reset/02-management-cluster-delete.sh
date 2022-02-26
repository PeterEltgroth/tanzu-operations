read -p "AWS Region Code (us-east-2): " aws_region_code

if [[ -z $aws_region_code ]]
then
	aws_region_code=us-east-2
fi

export AWS_REGION=${aws_region_code}

tanzu management-cluster delete

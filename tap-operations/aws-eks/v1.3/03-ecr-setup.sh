read -p "AWS Region Code: " aws_region_code

export AWS_REGION=$aws_region_code

aws ecr create-repository --repository-name tap-images --region $AWS_REGION
aws ecr create-repository --repository-name tap-build-service --region $AWS_REGION

read -p "Full Cluster Name: " full_cluster
read -p "AWS Region Code: " aws_region_code

arn=arn:aws:eks:${aws_region_code}:964978768106:cluster

if [[ $aws_region_code = "us-west-1" ]]
then
	aws eks create-cluster \
	   --name $full_cluster \
	   --region $aws_region_code \
	   --kubernetes-version 1.23 \
	   --role-arn arn:aws:iam::964978768106:role/vmware-eks-role \
	   --resources-vpc-config subnetIds=subnet-0c277f0344e18e39b,subnet-0475a32ab6d3501d6

	aws eks wait cluster-active --name $full_cluster

	aws eks create-nodegroup \
			--cluster-name $full_cluster \
			--nodegroup-name "${full_cluster}-node-group" \
			--disk-size 100 \
			--scaling-config minSize=3,maxSize=3,desiredSize=3 \
			--subnets "subnet-0c277f0344e18e39b" "subnet-0475a32ab6d3501d6" \
			--instance-types m5.2xlarge \
			--node-role arn:aws:iam::964978768106:role/vmware-nodegroup-role \
			--kubernetes-version 1.23
fi

aws eks wait nodegroup-active --cluster-name $full_cluster --nodegroup-name ${full_cluster}-node-group

rm $HOME/.kube/config

aws eks update-kubeconfig --name $full_cluster --region $aws_region_code

kubectl config rename-context ${arn}/${full_cluster} $full_cluster

kubectl config use-context $full_cluster

#INSTALL CSI DRIVER PLUGIN (REQUIRED FOR K8S 1.23)
aws eks create-addon \
  --cluster-name $full_cluster \
  --addon-name aws-ebs-csi-driver \
  --service-account-role-arn arn:aws:iam::964978768106:role/AmazonEKS_EBS_CSI_DriverRole
	
aws eks describe-cluster --name $full_cluster --query "cluster.identity.oidc.issuer" --output text

read -p "OIDC ID: " oidc_id

rm aws-ebs-csi-driver-trust-policy.json
cat <<EOF | tee aws-ebs-csi-driver-trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::964978768106:oidc-provider/oidc.eks.${aws_region_code}.amazonaws.com/id/${oidc_id}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.${aws_region_code}.amazonaws.com/id/${oidc_id}:aud": "sts.amazonaws.com",
          "oidc.eks.${aws_region_code}.amazonaws.com/id/${oidc_id}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF

aws iam create-role \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --assume-role-policy-document file://"aws-ebs-csi-driver-trust-policy.json"
	
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --role-name AmazonEKS_EBS_CSI_DriverRole
	
kubectl annotate serviceaccount ebs-csi-controller-sa \
    -n kube-system \
    eks.amazonaws.com/role-arn=arn:aws:iam::964978768106:role/AmazonEKS_EBS_CSI_DriverRole


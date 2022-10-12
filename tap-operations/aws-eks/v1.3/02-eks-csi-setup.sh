read -p "Cluster Name: " cluster_name
read -p "AWS Region Code: " aws_region_code

kubectl config use-context $cluster_name

#https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi.html
#INSTALL CSI DRIVER PLUGIN (REQUIRED FOR K8S 1.23)
aws eks create-addon \
  --cluster-name $cluster_name \
  --addon-name aws-ebs-csi-driver \
  --service-account-role-arn arn:aws:iam::964978768106:role/AmazonEKS_EBS_CSI_DriverRole

#https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text

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

aws iam detach-role-policy \
	--role-name AmazonEKS_EBS_CSI_DriverRole \
	--policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy
	
aws iam delete-role \
	--role-name AmazonEKS_EBS_CSI_DriverRole

aws iam create-role \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --assume-role-policy-document file://"aws-ebs-csi-driver-trust-policy.json"
	
aws iam attach-role-policy \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy
	
kubectl annotate serviceaccount ebs-csi-controller-sa \
    -n kube-system --overwrite \
    eks.amazonaws.com/role-arn=arn:aws:iam::964978768106:role/AmazonEKS_EBS_CSI_DriverRole
		

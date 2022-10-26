read -p "Cluster Name: " cluster_name
read -p "AWS Region Code: " aws_region_code
read -p "AWS Account ID: " account_id

echo "Using context: arn:aws:eks:${aws_region_code}:${account_id}:cluster/${cluster_name}"
kubectl config use-context "arn:aws:eks:${aws_region_code}:${account_id}:cluster/${cluster_name}"

#https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi.html
#INSTALL CSI DRIVER PLUGIN (REQUIRED FOR K8S 1.23)
aws eks create-addon \
  --cluster-name $cluster_name \
  --addon-name aws-ebs-csi-driver \
  --service-account-role-arn "arn:aws:iam::${account_id}:role/AmazonEKS_EBS_CSI_DriverRole"

#https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text

#https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | awk -F '/' '{print $5}')
echo "OIDC Id: $oidc_id"

# Check if a IAM OIDC provider exists for the cluster
# https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
if [[ -z $(aws iam list-open-id-connect-providers | grep $oidc_id) ]]; then
  echo "Creating IAM OIDC provider"
  if ! [ -x "$(command -v eksctl)" ]; then
    echo "Error `eksctl` CLI is required, https://eksctl.io/introduction/#installation" >&2
    exit 1
  fi

  eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
fi

rm aws-ebs-csi-driver-trust-policy.json
cat <<EOF | tee aws-ebs-csi-driver-trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${account_id}:oidc-provider/oidc.eks.${aws_region_code}.amazonaws.com/id/${oidc_id}"
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
    eks.amazonaws.com/role-arn=arn:aws:iam::${account_id}:role/AmazonEKS_EBS_CSI_DriverRole

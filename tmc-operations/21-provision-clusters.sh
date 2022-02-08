read -p "Cluster Name: " cluster_name
read -p "Cluster Group: " cluster_group
read -p "AWS Region Code: " aws_region_code

rm tmc/configs/cluster-provisioned.yaml
cat <<EOF | tee tmc/configs/cluster-provisioned.yaml
fullName:
  managementClusterName: aws-hosted
  name: $cluster_name
  orgId: 86514df0-46a7-4b33-857d-954ba2970773
  provisionerName: tmc-aws-provisioner
meta:
  labels:
    tmc.cloud.vmware.com/creator: mijames
spec:
  clusterGroupName: $cluster_group
  tkgAws:
    distribution:
      provisionerCredentialName: tmc-aws-credentials
      region: $aws_region_code
      version: 1.20.11-1-amazon2
    settings:
      network:
        cluster:
          pods:
          - cidrBlocks: 192.168.0.0/16
          services:
          - cidrBlocks: 10.96.0.0/12
        provider:
          vpc:
            cidrBlock: 10.0.0.0/16
      security:
        sshKey: tanzu-operations-${aws_region_code}
    topology:
      controlPlane:
        availabilityZones:
        - ${aws_region_code}a
        instanceType: m5.large
type:
  kind: Cluster
  package: vmware.tanzu.manage.v1alpha1.cluster
  version: v1alpha1
EOF

tmc cluster create -f tmc/configs/cluster-provisioned.yaml



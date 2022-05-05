#!bin/bash

subscription=nycpivot

aws_access_key_id=$(az keyvault secret show --name aws-account-access-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)
aws_secret_access_key=$(az keyvault secret show --name aws-account-secret-key --subscription $subscription --vault-name tanzuvault --query value --output tsv)

wget https://tanzustorage.blob.core.windows.net/tanzu/kubectl-linux-v1.22.5+vmware.1.gz -O tkg-v1.5.1/kubectl-linux-v1.22.5+vmware.1.gz
wget https://tanzustorage.blob.core.windows.net/tanzu/tanzu-cli-bundle-linux-amd64-v1.5.1.tar -O tkg-v1.5.1/tanzu-cli-bundle-linux-amd64-v1.5.1.tar

rm tkg-v1.5.1/Dockerfile
cat <<EOF | tee tkg-v1.5.1/Dockerfile
FROM ubuntu AS build

RUN apt-get update
RUN apt-get install ca-certificates -y

WORKDIR /home/ubuntu/tanzu

COPY kubectl-linux-v1.22.5+vmware.1.gz .
RUN gunzip kubectl-linux-v1.22.5+vmware.1.gz
RUN install kubectl-linux-v1.22.5+vmware.1 /usr/local/bin/kubectl

COPY tanzu-cli-bundle-linux-amd64-v1.5.1.tar .
RUN tar -xvf tanzu-cli-bundle-linux-amd64-v1.5.1.tar
RUN install cli/core/v0.11.1/tanzu-core-linux_amd64 /usr/local/bin/tanzu

RUN tanzu init

#PLUGINS
RUN tanzu plugin clean
RUN tanzu plugin sync
RUN tanzu plugin list


#CARVEL (YTT, KAPP, KBLD, IMGPKG)
RUN gunzip cli/ytt-linux-amd64-v0.35.1+vmware.1.gz
RUN chmod ugo+x cli/ytt-linux-amd64-v0.35.1+vmware.1
RUN mv cli/ytt-linux-amd64-v0.35.1+vmware.1 /usr/local/bin/ytt

RUN gunzip cli/kapp-linux-amd64-v0.42.0+vmware.1.gz
RUN chmod ugo+x cli/kapp-linux-amd64-v0.42.0+vmware.1
RUN mv cli/kapp-linux-amd64-v0.42.0+vmware.1 /usr/local/bin/kapp

RUN gunzip cli/kbld-linux-amd64-v0.31.0+vmware.1.gz
RUN chmod ugo+x cli/kbld-linux-amd64-v0.31.0+vmware.1
RUN mv cli/kbld-linux-amd64-v0.31.0+vmware.1 /usr/local/bin/kbld

RUN gunzip cli/imgpkg-linux-amd64-v0.18.0+vmware.1.gz
RUN chmod ugo+x cli/imgpkg-linux-amd64-v0.18.0+vmware.1
RUN mv cli/imgpkg-linux-amd64-v0.18.0+vmware.1 /usr/local/bin/imgpkg

ENV AWS_ACCESS_KEY_ID=$aws_access_key_id
ENV AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
ENV AWS_DEFAULT_REGION=us-east-1
ENV AWS_SSH_KEYNAME=tanzu-operations-us-east-1
ENV MGMT_CLUSTER_NAME=tanzu-management-cluster

WORKDIR /home/ubuntu

COPY tanzu-management-cluster-dev.sh .

RUN bash tanzu-management-cluster-dev.sh

EOF

docker build -t tanzu-management-cluster:1.5.1 tkg-v1.5.1/.

rm tkg-v1.5.1/kubectl-linux-v1.22.5+vmware.1.gz
rm tkg-v1.5.1/tanzu-cli-bundle-linux-amd64-v1.5.1.tar

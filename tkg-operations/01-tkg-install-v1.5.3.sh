mkdir tanzu
cd tanzu

wget https://tanzustorage.blob.core.windows.net/tanzu/tanzu-cli-bundle-linux-amd64-v1.5.3.tar
tar -xvf tanzu-cli-bundle-linux-amd64-v1.5.3.tar
rm tanzu-cli-bundle-linux-amd64-v1.5.3.tar

sudo install cli/core/v0.11.4/tanzu-core-linux_amd64 /usr/local/bin/tanzu

tanzu init
tanzu version

#PLUGINS
tanzu plugin clean
tanzu plugin sync
tanzu plugin list


#CARVEL (YTT, KAPP, KBLD, IMGPKG)
gunzip cli/ytt-linux-amd64-v0.37.0+vmware.1.gz
chmod ugo+x cli/ytt-linux-amd64-v0.37.0+vmware.1
sudo mv cli/ytt-linux-amd64-v0.37.0+vmware.1 /usr/local/bin/ytt

gunzip cli/kapp-linux-amd64-v0.42.0+vmware.2.gz
chmod ugo+x cli/kapp-linux-amd64-v0.42.0+vmware.2
sudo mv cli/kapp-linux-amd64-v0.42.0+vmware.2 /usr/local/bin/kapp

gunzip cli/kbld-linux-amd64-v0.31.0+vmware.1.gz
chmod ugo+x cli/kbld-linux-amd64-v0.31.0+vmware.1
sudo mv cli/kbld-linux-amd64-v0.31.0+vmware.1 /usr/local/bin/kbld

gunzip cli/imgpkg-linux-amd64-v0.22.0+vmware.1.gz
chmod ugo+x cli/imgpkg-linux-amd64-v0.22.0+vmware.1
sudo mv cli/imgpkg-linux-amd64-v0.22.0+vmware.1 /usr/local/bin/imgpkg

gunzip cli/vendir-linux-amd64-v0.23.1+vmware.1.gz
chmod ugo+x cli/vendir-linux-amd64-v0.23.1+vmware.1
sudo mv cli/vendir-linux-amd64-v0.23.1+vmware.1 /usr/local/bin/vendir

cd $HOME

#CLUSTERCTL
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.1.2/clusterctl-linux-amd64 -o clusterctl
sudo mv ./clusterctl /usr/local/bin/clusterctl
chmod +x /usr/local/bin/clusterctl


#VELERO
wget https://tanzustorage.blob.core.windows.net/tanzu/velero-linux-v1.7.0+vmware.1.gz
gzip -d velero-linux-v1.7.0+vmware.1.gz

sudo install velero-linux-v1.7.0+vmware.1 /usr/local/bin/velero
rm velero-linux-v1.7.0+vmware.1



aws s3api create-bucket \
	--bucket nycpivot-velero-backups \
	--region us-west-1 \
	--create-bucket-configuration LocationConstraint=us-west-1


helm install velero vmware-tanzu/velero \
--namespace velero \
--create-namespace \
--set-file credentials.secretContents.cloud=.aws/credentials \
--set configuration.provider=aws \
--set configuration.backupStorageLocation.name=default \
--set configuration.backupStorageLocation.bucket=nycpivot-velero-backups \
--set configuration.backupStorageLocation.config.region=us-west-1 \
--set snapshotsEnabled=false \
--set initContainers[0].name=velero-plugin-for-aws \
--set initContainers[0].image=velero/velero-plugin-for-aws:v1.2.0 \
--set initContainers[0].volumeMounts[0].mountPath=/target \
--set initContainers[0].volumeMounts[0].name=plugins
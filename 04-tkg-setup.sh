mkdir tanzu
cd tanzu

#TKG
wget https://tanzustorage.blob.core.windows.net/tkg-1dot3/tanzu-cli-bundle-v1.3.1-linux-amd64.tar
tar -xvf tanzu-cli-bundle-v1.3.1-linux-amd64.tar
rm tanzu-cli-bundle-v1.3.1-linux-amd64.tar

sudo install cli/core/v1.3.1/tanzu-core-linux_amd64 /usr/local/bin/tanzu
tanzu version

tanzu plugin install --local cli all
tanzu plugin list


#KUBECTL
wget https://tanzustorage.blob.core.windows.net/tkg-1dot3/kubectl-linux-v1.20.5-vmware.1.gz
gzip -d kubectl-linux-v1.20.5-vmware.1.gz

sudo install kubectl-linux-v1.20.5-vmware.1 /usr/local/bin/kubectl
rm kubectl-linux-v1.20.5-vmware.1
kubectl version


#CARVEL (YTT, KAPP, KBLD, IMGPKG)
gunzip cli/ytt-linux-amd64-v0.31.0+vmware.1.gz
chmod ugo+x cli/ytt-linux-amd64-v0.31.0+vmware.1
sudo mv cli/ytt-linux-amd64-v0.31.0+vmware.1 /usr/local/bin/ytt

gunzip cli/kapp-linux-amd64-v0.36.0+vmware.1.gz
chmod ugo+x cli/kapp-linux-amd64-v0.36.0+vmware.1
sudo mv cli/kapp-linux-amd64-v0.36.0+vmware.1 /usr/local/bin/kapp

gunzip cli/kbld-linux-amd64-v0.28.0+vmware.1.gz
chmod ugo+x cli/kbld-linux-amd64-v0.28.0+vmware.1
sudo mv cli/kbld-linux-amd64-v0.28.0+vmware.1 /usr/local/bin/kbld

gunzip cli/imgpkg-linux-amd64-v0.5.0+vmware.1.gz
chmod ugo+x cli/imgpkg-linux-amd64-v0.5.0+vmware.1
sudo mv cli/imgpkg-linux-amd64-v0.5.0+vmware.1 /usr/local/bin/imgpkg

#velero
wget https://tanzustorage.blob.core.windows.net/tkg-1dot3/velero-linux-v1.5.4_vmware.1.gz
gzip -d velero-linux-v1.5.4_vmware.1.gz

sudo install velero-linux-v1.5.4_vmware.1 /usr/local/bin/velero
rm velero-linux-v1.5.4_vmware.1

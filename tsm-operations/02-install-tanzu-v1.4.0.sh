read -p "Azure Subscription: " subscription

mkdir tanzu
cd tanzu

wget https://tanzustorage.blob.core.windows.net/tanzu/tanzu-cli-bundle-linux-amd64-v1.4.tar
tar -xvf tanzu-cli-bundle-linux-amd64-v1.4.tar
rm tanzu-cli-bundle-linux-amd64-v1.4.tar

sudo install cli/core/v1.4/tanzu-core-linux_amd64 /usr/local/bin/tanzu
tanzu version

tanzu plugin install --local cli all
tanzu plugin list

#VELERO
wget https://tanzustorage.blob.core.windows.net/tanzu/velero-linux-v1.6.2_vmware.1.gz
gzip -d velero-linux-v1.6.2_vmware.1.gz

sudo install velero-linux-v1.6.2_vmware.1 /usr/local/bin/velero
rm velero-linux-v1.6.2_vmware.1


#CARVEL (YTT, KAPP, KBLD, IMGPKG)
gunzip cli/ytt-linux-amd64-v0.34.0+vmware.1.gz
chmod ugo+x cli/ytt-linux-amd64-v0.34.0+vmware.1
sudo mv cli/ytt-linux-amd64-v0.34.0+vmware.1 /usr/local/bin/ytt

gunzip cli/kapp-linux-amd64-v0.37.0+vmware.1.gz
chmod ugo+x cli/kapp-linux-amd64-v0.37.0+vmware.1
sudo mv cli/kapp-linux-amd64-v0.37.0+vmware.1 /usr/local/bin/kapp

gunzip cli/kbld-linux-amd64-v0.30.0+vmware.1.gz
chmod ugo+x cli/kbld-linux-amd64-v0.30.0+vmware.1
sudo mv cli/kbld-linux-amd64-v0.30.0+vmware.1 /usr/local/bin/kbld

gunzip cli/imgpkg-linux-amd64-v0.10.0+vmware.1.gz
chmod ugo+x cli/imgpkg-linux-amd64-v0.10.0+vmware.1
sudo mv cli/imgpkg-linux-amd64-v0.10.0+vmware.1 /usr/local/bin/imgpkg

cd $HOME

#TMC CLI
wget https://tanzustorage.blob.core.windows.net/tanzu/tmc -O tmc-cli
sudo mv tmc-cli /usr/local/bin/tmc
chmod +x /usr/local/bin/tmc

TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login
echo


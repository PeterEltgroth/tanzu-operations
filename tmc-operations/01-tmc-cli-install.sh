#TMC CLI
wget https://tanzustorage.blob.core.windows.net/tanzu/tmc -O tmc-cli
sudo mv tmc-cli /usr/local/bin/tmc
chmod +x /usr/local/bin/tmc

#TMC_API_TOKEN=$(az keyvault secret show --name tanzu-cloud-services-token --subscription nycpivot --vault-name tanzuvault --query value --output tsv)
TMC_API_TOKEN=$(az keyvault secret show --name tmc-token-mapbu --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

echo $TMC_API_TOKEN

tmc login
echo

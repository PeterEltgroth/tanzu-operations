read -p "Container Registry (without domain): " registry_name

tanzu package available get ootb-supply-chain-basic.tanzu.vmware.com/0.5.1 --values-schema -n tap-install

rm ootb-supply-chain-basic-values.yaml
cat <<EOF | tee ootb-supply-chain-basic-values.yaml
registry:
  server: ${registry_name}.azurecr.io
  repository: "supply-chain"
gitops:
  repository_prefix: git@github.com:vmware-tanzu/
  branch: main
  user_name: supplychain
  user_email: supplychain
  commit_message: supplychain@cluster.local
  ssh_secret: git-ssh
cluster_builder: default
service_account: default
EOF

tanzu package install ootb-supply-chain-basic \
  --package-name ootb-supply-chain-basic.tanzu.vmware.com \
  --version 0.5.1 \
  --namespace tap-install \
  --values-file ootb-supply-chain-basic-values.yaml
#tanzu package install ootb-supply-chain-basic --package-name ootb-supply-chain-basic.tanzu.vmware.com --version 0.5.1 --namespace tap-install --values-file ootb-supply-chain-basic-values.yaml
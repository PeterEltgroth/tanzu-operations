read -p "Azure Container Registry (without domain): " az_registry

tanzu package available get ootb-supply-chain-basic.tanzu.vmware.com/0.4.0-build.2 --values-schema -n tap-install

rm ootb-supply-chain-basic-values.yaml
cat <<EOF | tee ootb-supply-chain-basic-values.yaml
registry:
  server: ${az_registry}.azurecr.io
  repository: "tap-apps"
service_account: default
EOF

tanzu package install ootb-supply-chain-basic \
  --package-name ootb-supply-chain-basic.tanzu.vmware.com \
  --version 0.4.0-build.2 \
  --namespace tap-install \
  --values-file ootb-supply-chain-basic-values.yaml
#tanzu package install ootb-supply-chain-basic --package-name ootb-supply-chain-basic.tanzu.vmware.com --version 0.4.0-build.2 --namespace tap-install --values-file ootb-supply-chain-basic-values.yaml
read -p "Azure Subscription: " subscription
read -p "Pivotal Username (mjames@pivotal.io): " pivot_username
read -p "Azure Container Registry (without domain): " az_registry
read -p "Azure Container Registry Password: " az_registry_password

pivot_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=$pivot_username
export INSTALL_REGISTRY_PASSWORD=$pivot_password

kubectl create ns tap-install

tanzu secret registry add tap-registry \
  --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} \
  --server ${INSTALL_REGISTRY_HOSTNAME} \
  --export-to-all-namespaces --yes --namespace tap-install
#tanzu secret registry add tap-registry --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} --server ${INSTALL_REGISTRY_HOSTNAME} --export-to-all-namespaces --yes --namespace tap-install

tanzu package repository add tanzu-tap-repository \
  --url registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:0.4.0 \
  --namespace tap-install
#tanzu package repository add tanzu-tap-repository --url registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:0.4.0 --namespace tap-install

echo
read -p "tanzu package repository get tanzu-tap-repository --namespace tap-install"
tanzu package repository get tanzu-tap-repository --namespace tap-install

echo
read -p "tanzu package available list --namespace tap-install"
tanzu package available list --namespace tap-install

echo
read -p "tanzu package available list tap.tanzu.vmware.com --namespace tap-install"
tanzu package available list tap.tanzu.vmware.com --namespace tap-install


rm tap-values.yaml
cat <<EOF | tee tap-values.yaml
profile: dev
ceip_policy_disclosed: true

buildservice:
  kp_default_repository: ${az_registry}.azurecr.io/build-service
  kp_default_repository_username: $az_registry
  kp_default_repository_password: $az_registry_password
  tanzunet_username: $pivot_username
  tanzunet_password: $pivot_password

supply_chain: basic

ootb_supply_chain_basic:
  registry:
    server: ${az_registry}.azurecr.io
    repository: "supply-chain"

tap_gui:
  service_type: LoadBalancer

metadata_store:
  app_service_type: LoadBalancer

EOF

tanzu package install tap -p tap.tanzu.vmware.com -v 0.4.0 --values-file tap-values.yaml -n tap-install
tanzu package installed get tap -n tap-install
tanzu package installed list -A

kubectl get svc -n tap-gui
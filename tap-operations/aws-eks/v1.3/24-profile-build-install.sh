cluster_name=tap-profile-build
target_registry=tanzuapplicationplatform
git_catalog_repository=tanzu-application-platform
app_domain=apps.tap.nycpivot.com

pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription nycpivot --vault-name tanzuvault --query value --output tsv)
target_registry_password=$(az keyvault secret show --name tanzu-application-platform-secret --subscription nycpivot --vault-name tanzuvault --query value --output tsv)
github_token=$(az keyvault secret show --name github-token-nycpivot --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

#export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=mjames@pivotal.io
export INSTALL_REGISTRY_PASSWORD=$pivnet_password

kubectl config use-context $cluster_name

#APPEND GUI SETTINGS
rm tap-values-build.yaml
cat <<EOF | tee tap-values-build.yaml
profile: build
ceip_policy_disclosed: true
shared:
  ingress_domain: "${app_domain}"
buildservice:
  kp_default_repository: ${target_registry}.azurecr.io/build-service
  kp_default_repository_username: $target_registry
  kp_default_repository_password: $target_registry_password
supply_chain: basic
ootb_supply_chain_basic:
  registry:
    server: ${target_registry}.azurecr.io
    repository: "supply-chain"
  gitops:
    ssh_secret: "" # (Optional) Defaults to "".
  cluster_builder: default
  service_account: default
grype:
  namespace: "default"
  targetImagePullSecret: "registry-credentials"
scanning:
  metadataStore:
    url: "" # Configuration is moved, so set this string to empty.
EOF

tanzu package install tap -p tap.tanzu.vmware.com -v 1.3.0 --values-file tap-values-build.yaml -n tap-install
tanzu package installed get tap -n tap-install
tanzu package installed list -A

cluster_name=tap-profile-run
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
rm tap-values-run.yaml
cat <<EOF | tee tap-values-run.yaml
profile: run
ceip_policy_disclosed: true

shared:
  ingress_domain: $app_domain
supply_chain: basic
contour:
  infrastructure_provider: aws
  envoy:
    service:
      aws:
        LBType: nlb
appliveview_connector:
  backend:
    sslDisabled: true
    ingressEnabled: true
    host: tap-profile-view.${app_domain}
EOF

tanzu package install tap -p tap.tanzu.vmware.com -v 1.3.0 --values-file tap-values-run.yaml -n tap-install
tanzu package installed get tap -n tap-install
tanzu package installed list -A

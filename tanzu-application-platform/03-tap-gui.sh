read -p "Azure Subscription: " subscription
read -p "Pivotal Username (mjames@pivotal.io): " pivot_username
read -p "Azure Container Registry (without domain): " az_registry
read -p "Azure Container Registry Password: " az_registry_password
read -p "External IP: " external_ip
read -p "Git Catalog Url: " git_catalog_url
read -p "Domain Name (apps.tap.us-east-2.nycpivot.com): " app_domain

pivot_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=$pivot_username
export INSTALL_REGISTRY_PASSWORD=$pivot_password

github_token_nycpivot=$(az keyvault secret show --name github-token-nycpivot --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

#APPEND GUI SETTINGS
rm tap-values.yaml
cat <<EOF | tee tap-values.yaml
profile: dev
ceip_policy_disclosed: true
buildservice:
  kp_default_repository: ${az_registry}.azurecr.io/build-service
  kp_default_repository_username: $az_registry
  kp_default_repository_password: $az_registry_password
  tanzunet_username: "${pivot_username}"
  tanzunet_password: "${pivot_password}"
supply_chain: basic
ootb_supply_chain_basic:
  registry:
    server: ${az_registry}.azurecr.io
    repository: "supply-chain"
metadata_store:
  app_service_type: LoadBalancer
tap_gui:
  service_type: LoadBalancer
  app_config:
    app:
      baseUrl: http://$external_ip:7000
    integrations:
      github:
        - host: github.com
          token: $github_token_nycpivot
    catalog:
      locations:
        - type: url
          target: $git_catalog_url/catalog-info.yaml
    backend:
        baseUrl: http://$external_ip:7000
        cors:
          origin: http://$external_ip:7000
contour:
  infrastructure_provider: aws
  envoy:
    service:
      aws:
        LBType: nlb
cnrs:
  domain_name: $app_domain

EOF

tanzu package installed update tap \
 --package-name tap.tanzu.vmware.com \
 --version 0.4.0 -n tap-install \
 -f tap-values.yaml
#tanzu package installed update tap --package-name tap.tanzu.vmware.com --version 0.4.0 -n tap-install -f tap-values.yaml

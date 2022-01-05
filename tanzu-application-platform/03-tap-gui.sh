read -p "External IP: " external_ip
read -p "Git Catalog Url: " git_catalog_url
read -p "Domain Name: " app_domain

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
  tanzunet_username: $pivot_username
  tanzunet_password: $pivot_password

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
#tanzu package installed update tap --package-name tap.tanzu.vmware.com --version 0.4.0 -n tap-install -f tap-gui-values.yaml

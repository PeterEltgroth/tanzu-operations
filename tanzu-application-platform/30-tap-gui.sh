read -p "Azure Subscription: " subscription
read -p "Container Registry (without domain): " registry_name
read -p "Git Catalog Url (https://abc.com): " git_catalog_url
read -p "Domain Name (apps.tap.us-east-2.nycpivot.com): " app_domain

pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
registry_password=$(az keyvault secret show --name tanzu-application-registry-password --subscription $subscription --vault-name tanzuvault --query value --output tsv)
github_token=$(az keyvault secret show --name github-token-nycpivot --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

#export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=mjames@pivotal.io
export INSTALL_REGISTRY_PASSWORD=$pivnet_password

#APPEND GUI SETTINGS
rm tap-values.yaml
cat <<EOF | tee tap-values.yaml
profile: light
ceip_policy_disclosed: true
buildservice:
  kp_default_repository: ${registry_name}.azurecr.io/build-service
  kp_default_repository_username: $registry_name
  kp_default_repository_password: $registry_password
  tanzunet_username: "mjames@pivotal.io"
  tanzunet_password: "${pivnet_password}"
supply_chain: basic
ootb_supply_chain_basic:
  registry:
    server: ${registry_name}.azurecr.io
    repository: "supply-chain"
tap_gui:
  service_type: LoadBalancer
  ingressEnabled: "true"
  ingressDomain: "${app_domain}"
  app_config:
    app:
      baseUrl: http://tap-gui.${app_domain}
    catalog:
      locations:
        - type: url
          target: $git_catalog_url/catalog-info.yaml
    backend:
        baseUrl: http://tap-gui.${app_domain}
        cors:
          origin: http://tap-gui.${app_domain}
    integrations:
      github:
        - host: github.com
          token: $github_token
contour:
  infrastructure_provider: aws
  envoy:
    service:
      aws:
        LBType: nlb
cnrs:
  domain_name: $app_domain
metadata_store:
  app_service_type: LoadBalancer
EOF

tanzu package install tap -p tap.tanzu.vmware.com -v 1.0.0 --values-file tap-values.yaml -n tap-install
tanzu package installed get tap -n tap-install
tanzu package installed list -A

kubectl get svc -n tanzu-system-ingress

read -p "Tanzu System Ingress IP: " external_ip

nslookup $external_ip

read -p "Configure DNS wildcard"

echo http://tap-gui.apps.tap.us-east-2.nycpivot.com/


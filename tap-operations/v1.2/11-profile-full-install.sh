subscription=nycpivot
target_registry=tanzuapplicationplatform
git_catalog_repository=tanzu-application-platform
app_domain=apps.tap.nycpivot.com

pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
target_registry_password=$(az keyvault secret show --name tanzu-application-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
github_token=$(az keyvault secret show --name github-token-nycpivot --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

#export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=mjames@pivotal.io
export INSTALL_REGISTRY_PASSWORD=$pivnet_password

kubectl config get-contexts

read -p "Select context: " kube_context

kubectl config use-context $kube_context

#APPEND GUI SETTINGS
rm tap-values-full.yaml
cat <<EOF | tee tap-values-full.yaml
profile: full
shared:
	ingress_domain: "${app_domain}"
ceip_policy_disclosed: true
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
    ssh_secret: ""
  cluster_builder: default
  service_account: default
tap_gui:
  service_type: LoadBalancer
  app_config:
    app:
      baseUrl: http://tap-gui.${app_domain}
    catalog:
      locations:
        - type: url
          target: https://github.com/nycpivot/${git_catalog_repository}/catalog-info.yaml
    backend:
        baseUrl: http://tap-gui.${app_domain}
        cors:
          origin: http://tap-gui.${app_domain}
    integrations:
      github:
        - host: github.com
          token: $github_token
learningcenter:
  ingressDomain: "learningcenter.run.tap.nycpivot.com"
metadata_store:
  app_service_type: LoadBalancer
grype:
  namespace: "default"
  targetImagePullSecret: "registry-credentials"
contour:
  infrastructure_provider: aws
  envoy:
    service:
      aws:
        LBType: nlb
cnrs:
  domain_name: $app_domain
EOF

tanzu package install tap -p tap.tanzu.vmware.com -v 1.0.0 --values-file tap-values-full.yaml -n tap-install
tanzu package installed get tap -n tap-install
tanzu package installed list -A

kubectl get svc -n tanzu-system-ingress

read -p "Tanzu System Ingress IP: " external_ip

nslookup $external_ip

read -p "Configure DNS wildcard"

echo http://tap-gui.${app_domain}


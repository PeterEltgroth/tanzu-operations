read -p "Azure Subscription: " subscription
read -p "EKS Cluster Name: " eks_cluster_name
read -p "AWS Region Code: " aws_region_code
read -p "Container Registry (without domain): " registry_name
read -p "Git Catalog Url (https://abc.com): " git_catalog_url
read -p "Domain Name (apps.tap.us-east-2.nycpivot.com): " app_domain

pivnet_password=$(az keyvault secret show --name pivnet-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
registry_password=$(az keyvault secret show --name tanzu-application-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)
github_token=$(az keyvault secret show --name github-token-nycpivot --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

#export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:82dfaf70656b54dcba0d4def85ccae1578ff27054e7533d08320244af7fb0343
export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
export INSTALL_REGISTRY_USERNAME=mjames@pivotal.io
export INSTALL_REGISTRY_PASSWORD=$pivnet_password

kubectl config get-contexts
read -p "Select context: " kube_context

kubectl config use-context $eks_cluster_name

#APPEND GUI SETTINGS
rm tap-values.yaml
cat <<EOF | tee tap-values-build.yaml
profile: full
ceip_policy_disclosed: true
buildservice:
  kp_default_repository: ${registry_name}.azurecr.io/build-service
  kp_default_repository_username: $registry_name
  kp_default_repository_password: $registry_password
  tanzunet_username: "mjames@pivotal.io"
  tanzunet_password: "${pivnet_password}"
  descriptor_name: "tap-1.0.0-full"
  enable_automatic_dependency_updates: true
supply_chain: basic
ootb_supply_chain_basic:
  registry:
    server: ${registry_name}.azurecr.io
    repository: "supply-chain"
  gitops:
    ssh_secret: ""
  cluster_builder: default
  service_account: default
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
learningcenter:
  ingressDomain: "learningcenter.apps.tap.us-east-2.nycpivot.com"
metadata_store:
  app_service_type: LoadBalancer
grype:
  namespace: "default"
  targetImagePullSecret: "registry-credentials"
excluded_packages:
  - accelerator.apps.tanzu.vmware.com
  - run.appliveview.tanzu.vmware.com
  - api-portal.tanzu.vmware.com
  - cnrs.tanzu.vmware.com
  - ootb-delivery-basic.tanzu.vmware.com
  - developer-conventions.tanzu.vmware.com
  - image-policy-webhook.signing.apps.tanzu.vmware.com
  - learningcenter.tanzu.vmware.com
  - workshops.learningcenter.tanzu.vmware.com
  - services-toolkit.tanzu.vmware.com
  - service-bindings.labs.vmware.com
  - tap-gui.tanzu.vmware.com
EOF

tanzu package install tap -p tap.tanzu.vmware.com -v 1.0.0 --values-file tap-values-build.yaml -n tap-install
tanzu package installed get tap -n tap-install
tanzu package installed list -A

kubectl get svc -n tanzu-system-ingress

read -p "Tanzu System Ingress IP: " external_ip

nslookup $external_ip

read -p "Configure DNS wildcard"

echo http://tap-gui.apps.tap.nycpivot.com/


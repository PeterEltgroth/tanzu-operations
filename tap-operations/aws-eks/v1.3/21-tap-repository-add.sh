target_registry=tanzuapplicationplatform

kubectl config get-contexts

read -p "Select context: " kube_context

kubectl config use-context $kube_context

target_registry_secret=$(az keyvault secret show --name tanzu-application-platform-secret --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

docker login ${target_registry}.azurecr.io -u $target_registry -p $target_registry_secret

export INSTALL_REGISTRY_HOSTNAME=${target_registry}.azurecr.io
export INSTALL_REGISTRY_USERNAME=$target_registry
export INSTALL_REGISTRY_PASSWORD=$target_registry_secret
export TARGET_REPOSITORY=build-service
export TAP_VERSION=1.3.0-build.22

imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:${TAP_VERSION} --to-repo ${INSTALL_REGISTRY_HOSTNAME}/${TARGET_REPOSITORY}/tap-packages


#TAP-INSTALL
kubectl create ns tap-install

tanzu secret registry add tap-registry \
  --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} \
  --server ${INSTALL_REGISTRY_HOSTNAME} \
  --export-to-all-namespaces --yes --namespace tap-install

tanzu package repository add tanzu-tap-repository \
  --url ${INSTALL_REGISTRY_HOSTNAME}/${TARGET_REPOSITORY}/tap-packages:$TAP_VERSION \
  --namespace tap-install

sleep 30

tanzu package repository get tanzu-tap-repository --namespace tap-install
sleep 5

tanzu package available list --namespace tap-install
sleep 5

tanzu package available list tap.tanzu.vmware.com --namespace tap-install
sleep 5




read -p "Registry Url: " registry_url
read -p "Registry Username: " registry_user
read -p "Registry Password: " registry_pass

if [[ -z $registry_url ]]
then
	registry_url=tanzuapplicationplatform.azurecr.io
fi

if [[ -z $registry_user ]]
then
	registry_user=tanzuapplicationregistry
fi

tap_registry_secret=$(az keyvault secret show --name tanzu-application-platform-secret --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

if [[ -z $registry_pass ]]
then
	registry_pass=$tap_registry_secret
fi

docker login $registry_url -u $registry_user -p $registry_pass

export INSTALL_REGISTRY_HOSTNAME=$registry_url
export INSTALL_REGISTRY_USERNAME=$registry_user
export INSTALL_REGISTRY_PASSWORD=$tap_registry_secret
export TARGET_REPOSITORY=build-service
export TAP_VERSION=1.2.0

imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:${TAP_VERSION} --to-repo ${INSTALL_REGISTRY_HOSTNAME}/${TARGET_REPOSITORY}/tap-packages

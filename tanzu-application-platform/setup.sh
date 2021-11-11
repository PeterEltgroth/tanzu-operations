kubectl config get-contexts

read -p "Target Context: " target_context
read -p "Pivotal Username: " pivot_username
read -p "Pivotal Password: " pivot_password
read -p "Azure Subscription: " subscription
read -p "Package Name: " package_name
read -p "Package Version: " package_version

kubectl config use-context $target_context 

kubectl create ns tap-install

kubectl create secret docker-registry tap-registry \
	-n tap-install \
	--docker-server='registry.pivotal.io' \
	--docker-username=$pivot_username \
	--docker-password=$pivot_password


refresh_token=$(az keyvault secret show --name pivnet-api-refresh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)
token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d '{"refresh_token":"'${refresh_token}'"}')
access_token=$(echo ${token} | jq -r .access_token)

curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Bearer ${access_token}" -X GET https://network.pivotal.io/api/v2/authentication

wget -O "operations-setup/tap-sample-package-repo.yaml" --header="Authorization: Bearer ${access_token}" https://network.pivotal.io/api/v2/products/tanzu-application-platform/releases/941562/product_files/1029762/download
wget -O "operations-setup/tap-sample-accelerators-0-2.yaml" --header="Authorization: Bearer ${access_token}" https://network.tanzu.vmware.com/api/v2/products/app-accelerator/releases/943731/product_files/1022094/download

kapp deploy -a tap-package-repo -n tap-install -f operations-setup/tap-sample-package-repo.yaml -y

sleep 5m

tanzu package repository list -n tap-install
wait

tanzu package available list -n tap-install
wait

tanzu package available list $package_name/$package_version -n tap-install
wait

tanzu package available get $package_name/$package_version --values-schema -n tap-install


#CLOUD NATIVE RUNTIMES
tanzu package install cloud-native-runtimes -p $package_name -v $package_version -n tap-install -f operations-setup/tap-cnr-values.yaml


#FLUX
kubectl delete -n flux-system networkpolicies --all
kapp deploy -a flux -f https://github.com/fluxcd/flux2/releases/download/v0.15.0/install.yaml

#FLUX - TKG ONLY
#kapp deploy -a flux -f https://github.com/fluxcd/flux2/releases/download/v0.15.0/install.yaml \
#--filter '{"not": {"resource": {"kinds": ["NetworkPolicy"]}}}'


#APPLICATION ACCELERATOR
tanzu package install app-accelerator -p accelerator.apps.tanzu.vmware.com -v 0.2.0 -n tap-install -f operations-setup/tap-app-accelerator-values.yaml
kubectl apply -f operations-setup/tap-sample-accelerators-0-2.yaml

#APPLICATION LIVE VIEW
tanzu package install app-live-view -p appliveview.tanzu.vmware.com -v 0.1.0 -n tap-install -f operations-setup/tap-app-live-view-values.yaml


#VERIFY
tanzu package installed list -n tap-install

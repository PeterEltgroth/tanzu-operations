read -p "Azure Subscription: " subscription

tmc_build_cluster=tmc-build-cluster

wavefront_token=$(az keyvault secret show --name wavefront-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

kubectl config use-context ${tmc_build_cluster}

helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update

kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${tmc_build_cluster} --namespace wavefront

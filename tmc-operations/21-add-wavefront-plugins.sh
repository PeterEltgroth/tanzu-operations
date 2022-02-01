tmc_custom_cluster=tmc-custom-cluster

wavefront_token=$(az keyvault secret show --name wavefront-token --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

kubectl config use-context ${tmc_custom_cluster}

helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update

kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${tmc_custom_cluster} --namespace wavefront

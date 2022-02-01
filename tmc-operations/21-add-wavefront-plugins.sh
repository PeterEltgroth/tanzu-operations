tmc_custom_cluster=tmc-custom-cluster

wavefront_token=$(az keyvault secret show --name wavefront-token --subscription nycpivot --vault-name tanzuvault --query value --output tsv)

pe "kubectl config use-context ${tmc_custom_cluster}"
echo

pe "helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update"
echo

pe "kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${cluster_name} --namespace wavefront"

read -p "Azure subscription: " subscription

wavefront_token=$(az keyvault secret show --name wavefront-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

kubectl config get-contexts
echo

read -p "Select cluster: " cluster_name
echo

kubectl config use-context $cluster_name
echo

helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update
echo

kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${cluster_name} --namespace wavefront
echo


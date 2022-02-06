read -p "Azure Subscription: " subscription

tmc_build_cluster=tmc-build-cluster
tmc_development_cluster=tmc-development-cluster
tmc_staging_cluster=tmc-staging-cluster

wavefront_token=$(az keyvault secret show --name wavefront-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

#HOLD OFF TILL IT CAN BE DETERMINED HOW TO GET THE KUBECONFIG FOR A PROVISIONED TMC CLUSTER
#ADD TO BUILD CLUSTER
#kubectl config use-context ${tmc_build_cluster}-admin@${tmc_build_cluster}

#helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update

#kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${tmc_build_cluster} --namespace wavefront


#ADD TO DEVELOPMENT CLUSTER
kubectl config use-context $tmc_development_cluster

helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update

kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${tmc_development_cluster} --namespace wavefront


#ADD TO STAGING CLUSTER
kubectl config use-context $tmc_staging_cluster

helm repo add wavefront https://wavefronthq.github.io/helm/ && helm repo update

kubectl create namespace wavefront && helm install wavefront wavefront/wavefront --set wavefront.url=https://vmware.wavefront.com --set wavefront.token=${wavefront_token} --set clusterName=${tmc_staging_cluster} --namespace wavefront




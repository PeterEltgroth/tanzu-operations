read -p "Azure Subscription: " subscription
read -p "Cluster Name: " cluster_name

server_name=prod-2.nsxservicemesh.vmware.com

api_token=$(az keyvault secret show --name tanzu-service-mesh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export CSP_TOKEN=$api_token

token=$(curl "https://console.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize" -H "authority: console.cloud.vmware.com" -H "pragma: no-cache" -H "cache-control: no-cache" -H "accept: application/json, text/plain, */*" --data-raw "refresh_token=${CSP_TOKEN}")

access_token=$(echo ${token} | jq -r .access_token)

#GET THE REGISTRATION YAML
registration_yaml=$(curl "https://${server_name}/tsm/v1alpha1/clusters/onboard-url" -H "accept: application/json" -H "csp-auth-token: ${access_token}")
registration_url=$(echo $registration_yaml | jq .url)

#APPLY THE REGISTRATION YAML AND INSTALL AGENTS
kubectl config use-context $cluster_name
kubectl apply -f $registration_url

sleep 5

#REGISTER THE CLUSTER
put_response=$(curl -X PUT "https://${server_name}/tsm/v1alpha1/clusters/${cluster_name}?createOnly=true" -H "content-type: application/json" -H "accept: application/json" -H "csp-auth-token: ${access_token}" -d "{\"displayName\":\"${cluster_name}\",\"description\":\"${cluster_name}\",\"tags\":[\"${cluster_name}\"],\"autoInstallServiceMesh\":true,\"enableNamespaceExclusions\":false}")

cluster_token=$(echo $put_response | jq .token)

kubectl -n vmware-system-tsm create secret generic cluster-token --from-literal=token=$cluster_token

get_status=$(curl "https://${server_name}/tsm/v1alpha1/clusters/${cluster_name}" -H "accept: application/json" -H "csp-auth-token: ${access_token}")

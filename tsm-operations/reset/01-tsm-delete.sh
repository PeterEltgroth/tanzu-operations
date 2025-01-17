read -p "Azure Subscription: " subscription

server_name=prod-2.nsxservicemesh.vmware.com

api_token=$(az keyvault secret show --name tanzu-service-mesh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export CSP_TOKEN=$api_token

token=$(curl "https://console.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize" -H "authority: console.cloud.vmware.com" -H "pragma: no-cache" -H "cache-control: no-cache" -H "accept: application/json, text/plain, */*" --data-raw "refresh_token=${CSP_TOKEN}")

access_token=$(echo ${token} | jq -r .access_token)


#DELETE NYC-FITNESS-WEB
id=$(curl -X DELETE "https://${server_name}/tsm/v1alpha1/clusters/tsm-fitness-web" -H "csp-auth-token: ${access_token}")
delete_status=$(curl GET "https://${server_name}/tsm/v1alpha1/jobs/${id}")


#DELETE NYC-FITNESS-CATALOG
id=$(curl -X DELETE "https://${server_name}/tsm/v1alpha1/clusters/tsm-fitness-catalog" -H "csp-auth-token: ${access_token}")
delete_status=$(curl GET "https://${server_name}/tsm/v1alpha1/jobs/${id}")



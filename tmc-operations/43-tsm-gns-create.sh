read -p "Azure Subscription: " subscription

server_name=prod-2.nsxservicemesh.vmware.com

api_token=$(az keyvault secret show --name tanzu-service-mesh-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

export CSP_TOKEN=$api_token

token=$(curl "https://console.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize" -H "authority: console.cloud.vmware.com" -H "pragma: no-cache" -H "cache-control: no-cache" -H "accept: application/json, text/plain, */*" --data-raw "refresh_token=${CSP_TOKEN}")
access_token=$(echo ${token} | jq -r .access_token)

response=$(curl -X POST "https://${server_name}/tsm/v1alpha1/global-namespaces" -H "Content-Type: application/json" -H "Accept: application/json" -H "csp-auth-token: ${access_token}" -d '{ "name":"acme-fitness", "display_name":"Acme Fitness", "domain_name":"nycpivot.com", "description":"Acme Fitness", "mtls_enforced":true, "ca_type":"PreExistingCA", "ca":"default", "version":"1.0", "match_conditions":[ { "namespace":{ "type":"EXACT", "match":"default" }, "cluster":{ "type":"EXACT", "match":"tmc-staging-cluster" } }, { "namespace":{ "type":"EXACT", "match":"default" }, "cluster":{ "type":"EXACT", "match":"tmc-production-cluster" } } ] }')
echo

echo $response

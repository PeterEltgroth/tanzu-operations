    #catalog:
    #  locations:
    #    - type: url
    #      target: https://github.com/krisapplegate/tap-gui-catalogs/blob/main/yelb-demo/yelb-catalog/catalog-info.yaml
    #    - type: url
    #      target: https://github.com/krisapplegate/tap-gui-catalogs/blob/main/blank/catalog-info.yaml

#echo tap_gui: >> tap-values.yaml
#echo \  \service_type: LoadBalancer >> tap-values.yaml
#echo \  \app_config: >> tap-values.yaml
#echo \    \app: >> tap-values.yaml
#echo \      \baseUrl: http://$external_ip:7000 >> tap-values.yaml
#echo \    \integrations: >> tap-values.yaml
#echo \      \github: >> tap-values.yaml
#echo \        \- host: github.com >> tap-values.yaml
#echo \          \token: $github_token_nycpivot >> tap-values.yaml
#echo \    \catalog: >> tap-values.yaml
#echo \      locations: >> tap-values.yaml
#echo \        \- type: url >> tap-values.yaml
#echo \          \target: https://$git_catalog_url/catalog-info.yaml >> tap-values.yaml
#echo \    \backend: >> tap-values.yaml
#echo \        \baseUrl: http://$external_ip:7000 >> tap-values.yaml
#echo \        \cors: >> tap-values.yaml
#echo \          origin: http://$external_ip:7000 >> tap-values.yaml







#tanzu package installed update tap --package-name tap.tanzu.vmware.com --version 0.4.0 -n tap-install -f tap-values.yaml



#GIT-SSH
1. ssh-keygen -t rsa
2. vim .ssh/id_rsa.pub -> copy it to the git repo https://github.com/dhadukk/tanzu-java-web-app-latest/settings/keys
3. ssh-keyscan github.com > ./known_hosts
4. kubectl create secret generic git-ssh --from-file=.ssh/id_rsa --from-file=.ssh/id_rsa.pub --from-file=./known_hosts -n tap-install


#DEPLOY APP WORKLOAD
tanzu secret registry add registry-credentials --server tapcanadaregistry.azurecr.io --username tapcanadaregistry --password JBNO5NNeEoAuaFpue7iEoB8MYb=JBYgS --namespace default

tanzu apps workload create tanzu-java-web-app \
--git-repo GIT-URL-TO-PROJECT-REPO \
--git-branch main \
--type web \
--label app.kubernetes.io/part-of=tanzu-java-web-app \
--yes

#tanzu apps workload create tanzu-java-web-app --git-repo https://github.com/nycpivot/tanzu-java-web-app.git --git-branch main --type web --label app.kubernetes.io/part-of=tanzu-java-web-app --yes -n default

tanzu apps workload tail tanzu-java-web-app --since 10m --timestamp
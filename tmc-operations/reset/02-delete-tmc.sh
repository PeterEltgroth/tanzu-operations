#CLUSTER GROUPS
development_cluster_group=development-cluster-group
production_cluster_group=production-cluster-group

#CLUSTERS
tmc_build_cluster=tmc-build-cluster
tmc_staging_cluster=tmc-staging-cluster
tmc_development_cluster=tmc-development-cluster
tmc_production_cluster=tmc-production-cluster

#WORKSPACES
app_workspace=app-workspace
web_workspace=web-workspace

#NAMESPACES
production_web=production-web
production_api=production-api
production_app=production-app
production_data=production-data

#DELETE POLICIES
#tmc organization iam remove-binding -u michael.james.mj.mj@gmail.com -r organization.view
tmc workspace image-policy delete registry-policy --workspace-name $web_workspace
tmc workspace network-policy delete network-policy --workspace-name $app_workspace
tmc clustergroup security-policy delete security-policy --cluster-group-name $development_cluster_group
tmc clustergroup namespace-quota-policy delete quota-policy --cluster-group-name $development_cluster_group

#DELETE NAMESPACES
tmc cluster namespace delete $production_web --cluster-name $tmc_production_cluster --management-cluster-name attached --provisioner-name attached
tmc cluster namespace delete $production_api --cluster-name $tmc_production_cluster --management-cluster-name attached --provisioner-name attached
tmc cluster namespace delete $production_app --cluster-name $tmc_production_cluster --management-cluster-name attached --provisioner-name attached
tmc cluster namespace delete $production_data --cluster-name $tmc_production_cluster --management-cluster-name attached --provisioner-name attached

#DELETE WORKSPACES
tmc workspace delete $app_workspace
tmc workspace delete $web_workspace

#DELETE INTEGRATIONS
tmc cluster integration delete tanzu-service-mesh --cluster-name $tmc_production_cluster --management-cluster-name attached --provisioner-name attached
tmc cluster integration delete tanzu-observability-saas --cluster-name $tmc_production_cluster --management-cluster-name attached --provisioner-name attached

#DELETE CLUSTERS
#tmc cluster delete $tmc_build_cluster --management-cluster-name aws-hosted --provisioner-name tmc-aws-provisioner
tmc cluster delete $tmc_staging_cluster --management-cluster-name attached --provisioner-name attached
tmc cluster delete $tmc_development_cluster --management-cluster-name attached --provisioner-name attached
tmc cluster delete $tmc_production_cluster --management-cluster-name attached --provisioner-name attached


read -p "Enter to continue"


#DELETE CLUSTER GROUPS
tmc clustergroup delete $development_cluster_group
tmc clustergroup delete $production_cluster_group

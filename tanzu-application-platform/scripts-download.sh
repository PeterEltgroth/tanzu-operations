rm -rf tap
mkdir tap

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/00-reset.sh -O tap/00-reset.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/01-app-demo.sh -O tap/01-app-demo.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/02-tilt-demo.sh -O tap/02-tilt-demo.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/03-app-service-demo.sh -O tap/03-app-service-demo.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/10-pre-reqs-us-east-2.sh -O tap/10-pre-reqs-us-east-2.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/10-pre-reqs-us-west-1.sh -O tap/10-pre-reqs-us-west-1.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/11-pre-reqs-tanzu.sh -O tap/11-pre-reqs-tanzu.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/20-tap-packages.sh -O tap/20-tap-packages.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/30-tap-values-build.sh -O tap/30-tap-values-build.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/30-tap-values-run.sh -O tap/30-tap-values-run.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/50-developer-namespace.sh -O tap/50-developer-namespace.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/51-tilt.sh -O tap/51-tilt.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/60-deploy-rabbitmq-operator.sh -O tap/60-deploy-rabbitmq-operator.sh

rm demo-live.sh

rm -rf tap

mkdir tap

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/00-demo.sh -O tap/00-demo.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/01-pre-reqs.sh -O tap/01-pre-reqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/02-tap-packages.sh -O tap/02-tap-packages.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/03-tap-gui.sh -O tap/03-tap-gui.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/04-supply-chain.sh -O tap/04-supply-chain.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/05-developer-namespace.sh -O tap/05-developer-namespace.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/06-deploy-app.sh -O tap/06-deploy-app.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tanzu-application-platform/07-deploy-app-rabbitmq.sh -O tap/07-deploy-app-rabbitmq.sh

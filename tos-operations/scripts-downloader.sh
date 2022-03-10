rm -rf tos

mkdir tos

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/01-tos-prereqs.sh -O tos/01-tos-prereqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/02-k8s-prereqs.sh -O tos/02-k8s-prereqs.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/10-demo-ec2-integration.sh -O tos/10-demo-ec2-integration.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/11-demo-k8s-integration.sh -O tos/11-demo-k8s-integration.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/20-demo-github-prereqs.sh -O tos/20-demo-github-prereqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/21-demo-spring-petclinic-direct-ingestion.sh -O tos/21-demo-spring-petclinic-direct-ingestion.sh

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/30-demo-wavefront-proxy.sh -O tos/30-demo-wavefront-proxy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/31-demo-dropwizard-proxy.sh -O tos/31-demo-dropwizard-proxy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/32a-demo-dropwizard-proxy-shopping.sh -O tos/32a-demo-dropwizard-proxy-shopping.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/32b-demo-dropwizard-proxy-styling.sh -O tos/32b-demo-dropwizard-proxy-styling.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/32c-demo-dropwizard-proxy-delivery.sh -O tos/32c-demo-dropwizard-proxy-delivery.sh


mkdir tos/wavefront-collector-open-telemetry

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/wavefront-collector-open-telemetry/01-docker-install.sh -O tos/wavefront-collector-open-telemetry/01-docker-install.sh

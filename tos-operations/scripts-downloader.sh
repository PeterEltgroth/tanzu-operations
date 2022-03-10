rm -rf tos

mkdir tos

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/01-tos-prereqs.sh -O tos/01-tos-prereqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/02-demo-ec2-integration.sh -O tos/02-demo-ec2-integration.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/03-demo-wavefront-proxy.sh -O tos/03-demo-wavefront-proxy.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/04-demo-k8s-integration.sh -O tos/04-demo-k8s-integration.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/10-demo-github-prereqs.sh -O tos/10-demo-github-prereqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/11-demo-spring-petclinic-opentracing.sh -O tos/11-demo-spring-petclinic-opentracing.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/12-demo-dropwizard-wavefront.sh -O tos/12-demo-dropwizard-wavefront.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/12a-demo-dropwizard-wavefront-shopping.sh -O tos/12a-demo-dropwizard-wavefront-shopping.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/12b-demo-dropwizard-wavefront-styling.sh -O tos/12b-demo-dropwizard-wavefront-styling.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/12c-demo-dropwizard-wavefront-delivery.sh -O tos/12c-demo-dropwizard-wavefront-delivery.sh

mkdir tos/wavefront-collector-open-telemetry

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/wavefront-collector-open-telemetry/01-docker-install.sh -O tos/wavefront-collector-open-telemetry/01-docker-install.sh

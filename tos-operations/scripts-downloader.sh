rm -rf tos

mkdir tos

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/01-tos-prereqs.sh -O tos/01-tos-prereqs.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/02-demo-ec2-integration.sh -O tos/02-demo-ec2-integration.sh
wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/03-demo-spring.sh -O tos/03-demo-spring.sh

mkdir tos/wavefront-collector-open-telemetry

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/wavefront-collector-open-telemetry/01-docker-install.sh -O tos/wavefront-collector-open-telemetry/01-docker-install.sh

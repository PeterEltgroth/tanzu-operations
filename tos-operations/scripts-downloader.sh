rm -rf tos
mkdir tos

mkdir tos/spring-petclinic

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/spring-petclinic/01-spring-petclinic.sh -O tos/spring-petclinic/01-spring-petclinic.sh



mkdir tos/wavefront-collector-open-telemetry

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/wavefront-collector-open-telemetry/01-docker-install.sh -O tos/wavefront-collector-open-telemetry/01-docker-install.sh

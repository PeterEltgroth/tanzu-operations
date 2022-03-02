rm -rf tos
mkdir tos



mkdir tos/wavefront-collector-open-telemetry
mkdir tos/wavefront-collector-open-telemetry/bin

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/01-docker-install.sh -O tos/01-docker-install.sh

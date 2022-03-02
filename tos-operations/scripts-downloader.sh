rm -rf tos
mkdir tos

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/01-tmc-cli-install.sh -O tmc/01-tmc-cli-install.sh


mkdir tos/wavefront-collector-open-telemetry
mkdir tos/wavefront-collector-open-telemetry/bin

wget https://raw.githubusercontent.com/nycpivot/tanzu-operations/main/tos-operations/01-docker-install.sh -O tmc/01-docker-install.sh

wget https://github.com/open-telemetry/opentelemetry-collector-contrib/releases/download/v0.42.0/otelcontribcol_linux_amd64

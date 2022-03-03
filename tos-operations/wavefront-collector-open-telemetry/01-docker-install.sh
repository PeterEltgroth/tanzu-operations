subscription=nycpivot

wavefront_token=$(az keyvault secret show --name wavefront-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

docker run -d \
      -e WAVEFRONT_URL=https://vmware.wavefront.com/api/ \
      -e WAVEFRONT_TOKEN=${wavefront_token} \
      -e JAVA_HEAP_USAGE=512m \
      -e WAVEFRONT_PROXY_ARGS="--customTracingListenerPorts 30001" \
      -p 2878:2878 \
      -p 30001:30001 \
	  wavefronthq/proxy:latest
	  
wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.46.0/otelcol_0.46.0_linux_amd64.tar.gz
gzip -d otelcol_0.46.0_linux_amd64.tar.gz
sudo install otelcol /usr/local/bin/otelcol

rm otelcol_0.46.0_linux_amd64.tar.gz
rm otelcol

cat <<EOF | tee tos/wavefront-collector-open-telemetry/otel_collector_config.yaml
receivers:
   otlp:
      protocols:
          grpc:
              endpoint: "localhost:4317"
exporters:
    tanzuobservability:
      traces:
        endpoint: "http://localhost:30001"
      metrics:
        endpoint: "http://localhost:2878"
  # Proxy hostname and customTracing ListenerPort
processors:
    batch:
      timeout: 10s
    memory_limiter:
      check_interval: 1s
      limit_percentage: 50
      spike_limit_percentage: 30


service:
    pipelines:
      metrics:
        receivers: [otlp]
        exporters: [tanzuobservability]
        processors: [memory_limiter, batch]
      traces:
        receivers: [otlp]
        exporters: [tanzuobservability]
        processors: [memory_limiter, batch]
EOF

otelcol --config tos/wavefront-collector-open-telemetry/otel_collector_config.yaml

cd $HOME

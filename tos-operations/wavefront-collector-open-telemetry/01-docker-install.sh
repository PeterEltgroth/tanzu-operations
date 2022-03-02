subscription=nycpivot

wavefront_token=$(az keyvault secret show --name wavefront-token --subscription $subscription --vault-name tanzuvault --query value --output tsv)

docker run -d wavefronthq/proxy:latest
      -e WAVEFRONT_URL=https://vmware.wavefront.com/api/ \
      -e WAVEFRONT_TOKEN=${wavefront_token} \
      -e JAVA_HEAP_USAGE=512m \
      -e WAVEFRONT_PROXY_ARGS="--customTracingListenerPorts 30001" \
      -p 2878:2878 \
      -p 30001:30001

cd tos/wavefront-collector-open-telemetry/bin
wget https://github.com/open-telemetry/opentelemetry-collector-contrib/releases/download/v0.42.0/otelcontribcol_linux_amd64 -O otelcontribcol_linux_amd64
chmod +x otelcontribcol_linux_amd64

cat <<EOF | tee otel_collector_config.yaml
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
        exporters: [tansuobservability]
        processors: [memory_limiter, batch]
      traces:
        receivers: [otlp]
        exporters: [tanzuobservability]
        processors: [memory_limiter, batch]
EOF

otelcontribcol_linux_amd64 --config otel_collector_config.yaml

ch $HOME
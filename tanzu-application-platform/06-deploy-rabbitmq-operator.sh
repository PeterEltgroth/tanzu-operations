kapp -y deploy --app rmq-operator --file https://github.com/rabbitmq/cluster-operator/releases/download/v1.9.0/cluster-operator.yml

cat <<EOF | tee resource-claims-rmq.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: resource-claims-rmq
  labels:
    resourceclaims.services.apps.tanzu.vmware.com/controller: "true"
rules:
- apiGroups: ["rabbitmq.com"]
  resources: ["rabbitmqclusters"]
  verbs: ["get", "list", "watch", "update"]
EOF

kubectl apply -f resource-claims-rmq.yaml

cat <<EOF | tee rabbitmqcluster-reader.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: rabbitmqcluster-reader
rules:
  - apiGroups: ["rabbitmq.com"]
    resources: ["rabbitmqclusters"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: rabbitmqcluster-reader
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: rabbitmqcluster-reader
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: Group
    name: system:authenticated
EOF

kubectl apply -f rabbitmqcluster-reader.yaml

kubectl create namespace service-instances

cat <<EOF | tee rabbitmq-clusterresource.yaml
apiVersion: services.apps.tanzu.vmware.com/v1alpha1
kind: ClusterResource
metadata:
  name: rabbitmq
spec:
  shortDescription: It's a RabbitMQ cluster!
  resourceRef:
    group: rabbitmq.com
    kind: RabbitmqCluster
EOF

kubectl apply -f rabbitmq-clusterresource.yaml

cat <<EOF | tee example-rabbitmq-cluster-service-instance.yaml
apiVersion: rabbitmq.com/v1beta1
kind: RabbitmqCluster
metadata:
  name: example-rabbitmq-cluster-1
spec:
  replicas: 1
EOF

kubectl apply -f example-rabbitmq-cluster-service-instance.yaml
read -p "Azure Subscription: " subscription
read -p "Container Registry (tanzuapplicationregistry): " registry_name
read -p "Namespace (default): " namespace

if [[ -z $registry_name ]]
then
	registry_name=tanzuapplicationregistry
fi

if [[ -z $namespace ]]
then
	namespace=default
fi

registry_password=$(az keyvault secret show --name tanzu-application-registry-secret --subscription $subscription --vault-name tanzuvault --query value --output tsv)

kubectl config get-contexts
read -p "Select context: " kube_context

kubectl config use-context $kube_context

tanzu secret registry add registry-credentials --server ${registry_name}.azurecr.io --username "${registry_name}" --password "${registry_password}" --namespace $namespace

#kubectl create secret docker-registry registry-credentials --docker-server="${registry_name}.azurecr.io" --docker-username="${registry_name}" --docker-password="${registry_password}" -n $namespace

cat <<EOF | kubectl -n default apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: tap-registry
  annotations:
    secretgen.carvel.dev/image-pull-secret: ""
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: e30K

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: default
secrets:
  - name: registry-credentials
imagePullSecrets:
  - name: registry-credentials
  - name: tap-registry

---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: default
rules:
- apiGroups: [source.toolkit.fluxcd.io]
  resources: [gitrepositories]
  verbs: ['*']
- apiGroups: [source.apps.tanzu.vmware.com]
  resources: [imagerepositories]
  verbs: ['*']
- apiGroups: [carto.run]
  resources: [deliverables, runnables]
  verbs: ['*']
- apiGroups: [kpack.io]
  resources: [images]
  verbs: ['*']
- apiGroups: [conventions.apps.tanzu.vmware.com]
  resources: [podintents]
  verbs: ['*']
- apiGroups: [""]
  resources: ['configmaps']
  verbs: ['*']
- apiGroups: [""]
  resources: ['pods']
  verbs: ['list']
- apiGroups: [tekton.dev]
  resources: [taskruns, pipelineruns]
  verbs: ['*']
- apiGroups: [tekton.dev]
  resources: [pipelines]
  verbs: ['list']
- apiGroups: [kappctrl.k14s.io]
  resources: [apps]
  verbs: ['*']
- apiGroups: [serving.knative.dev]
  resources: ['services']
  verbs: ['*']
- apiGroups: [servicebinding.io]
  resources: ['servicebindings']
  verbs: ['*']
- apiGroups: [services.apps.tanzu.vmware.com]
  resources: ['resourceclaims']
  verbs: ['*']
- apiGroups: [scanning.apps.tanzu.vmware.com]
  resources: ['imagescans', 'sourcescans']
  verbs: ['*']

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: default
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: default
subjects:
  - kind: ServiceAccount
    name: default

EOF


#GIT-SSH
#1. ssh-keygen -t rsa
#2. vim .ssh/id_rsa.pub -> copy it to the git repo https://github.com/nycpivot/tanzu-java-web-app-latest/settings/keys
#3. ssh-keyscan github.com > ./known_hosts
#4. kubectl create secret generic git-ssh --from-file=.ssh/id_rsa --from-file=.ssh/id_rsa.pub --from-file=./known_hosts -n tap-install
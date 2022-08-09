#!/bin/bash

kubectl config get-contexts
read -p "Select context: " kube_context

kubectl config use-context $kube_context

tanzu package installed delete tap -n tap-install




tanzu package installed update tap --package-name tap.tanzu.vmware.com --version 1.0.0 -n tap-install -f tap-values-run.yaml

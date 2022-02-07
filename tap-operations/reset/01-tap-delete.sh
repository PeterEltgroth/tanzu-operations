#!/bin/bash

kubectl config get-contexts
read -p "Select context: " kube_context

kubectl config use-context $kube_context

tanzu package installed delete tap -n tap-install
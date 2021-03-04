Tanzu Operator
=============================

This repository contains the script(s) that automate the installation of various Tanzu products on an Ubuntu 18.04 virtual machine.

These include base services, such as, Docker, Kubernetes, and utilities and tools, as jq CLI.

You will be prompted for a token that is necessary to pull the images and files from the Pivotal Network (Pivnet).

The current script includes the following packages:

### Base

- Docker
- Kubernetes
- jq CLI

### Tanzu Build Service (TBS)

- kp-linux CLI
- build-service 1.0
- kapp
- ytt
- kbld
- descriptor-100.0.45.yaml

### Tanzu Kubernetes Grid (TKG)

- tkg CLI

The following command creates an initial configuration file in a new .tkg folder.

<pre>
	tkg get management-cluster
</pre>

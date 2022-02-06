#!/bin/bash

tmc cluster list

read -p "Cluster Name: " cluster_name

tmc cluster delete $cluster_name --management-cluster-name aws-hosted --provisioner-name tmc-aws-provisioner



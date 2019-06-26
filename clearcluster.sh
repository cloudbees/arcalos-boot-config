#!/usr/bin/env bash

echo "removing the cluster specific files"
rm -f env/parameters.yaml
rm -f env/cluster/values.yaml
rm -rf ~/.jx/localSecrets
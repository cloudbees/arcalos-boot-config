#!/bin/bash

NAME=$1

git clone https://github.com/cloudbees/arcalos
pushd arcalos
  sed -i "s|BOOT_GIT_REF=.*$|BOOT_GIT_REF=$PULL_PULL_SHA|g" ./templates/.secrets.defaults
  cat ./templates/.secrets.defaults
  ./create_aps_consumer_project.sh $NAME
  ./deploy_aps.sh $NAME
  ./verify.sh
popd

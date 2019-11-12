#!/bin/bash

set -e
set -u
set -o pipefail

NAME=$1
ARCALOS_SHA="" #pragma: allowlist secret

git clone https://github.com/cloudbees/arcalos

pushd arcalos
  if [ "" != "${ARCALOS_SHA}" ]
  then
    export USE_RELEASED_TEMPLATE=false
    BRANCH_NAME="pr-${ARCALOS_SHA}"
    git fetch origin ${ARCALOS_SHA} && git branch ${BRANCH_NAME} ${ARCALOS_SHA} && git checkout ${BRANCH_NAME}
  fi

  sed -i "s|BOOT_GIT_REF=.*$|BOOT_GIT_REF=$PULL_PULL_SHA|g" ./templates/.secrets.defaults
  cat ./templates/.secrets.defaults
  ./create_aps_consumer_project.sh $NAME
  ./deploy_aps.sh $NAME
  ./run_all_checks.sh $NAME
popd

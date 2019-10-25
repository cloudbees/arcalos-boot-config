#!/bin/bash

jx step create pr regex -r https://github.com/cloudbees/arcalos-jenkins-x-versions.git --files git/github.com/cloudbees/arcalos-boot-config.yml --regex '^version: (.*)$' --version $VERSION

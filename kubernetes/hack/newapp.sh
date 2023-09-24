#!/bin/bash

# Create a new app

# Style
# newapp <namespace> <appname>

[ -z $1 -o -z $2 ] && echo "define namespace or appname" && exit 1

# echo "$1 $2"
mkdir -p ../apps/$1/$2/app
touch ../apps/$1/$2/ks.yaml ../apps/$1/$2/app/kustomization.yaml ../apps/$1/$2/app/helmrelease.yaml
echo "  - ./$2/ks.yaml" >> ../apps/$1/kustomization.yaml

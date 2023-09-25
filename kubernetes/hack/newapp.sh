#!/bin/bash

# Create a new app

# Style
# newapp <namespace> <appname>

[ -z $1 -o -z $2 ] && echo "define namespace or appname" && exit 1

# echo "$1 $2"
mkdir -p ../apps/$1/$2/app
touch ../apps/$1/$2/app/helmrelease.yaml
cat <<EOF > ../apps/$1/$2/ks.yaml
---
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: $1-$2
  namespace: flux-system
spec:
  path: ./kubernetes/apps/$1/$2/app
  prune: true
  sourceRef:
    kind: GitRepository
    name: home-kubernetes
  interval: 30m
  retryInterval: 1m
  timeout: 3m
EOF
cat <<EOF > ../apps/$1/$2/app/kustomization.yaml
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - helmrelease.yaml
EOF
echo "  - ./$2/ks.yaml" >> ../apps/$1/kustomization.yaml

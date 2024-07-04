#!/bin/bash

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  labels:
    argocd.argoproj.io/secret-type: repository
  name: charts-repository-secret
  namespace: argocd
type: Opaque
data:
  sshPrivateKey: $(base64 -w 0 < ${GITHUB_DEPLOY_KEY})
  type: $(echo -n git | base64 -w 0)
  url:  $(echo -n ${GITHUB_REPOSITORY_URL} | base64 -w 0)
EOF

#!/usr/bin/env bash

if [[ -z "${USER_EMAIL}" ]]; then
  echo "Not configuring user or role as USER_EMAIL is not set"
else
  if jx get users | grep -q "${USER_EMAIL}"; then
     echo "User already configured"
  else
    jx create user --login=${USER_EMAIL}
  fi
  jx edit userroles --login=${USER_EMAIL} --role=owner
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    jenkins.io/created-by: jx
    team: jx
  name: jx-env-view
  namespace: jx
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: jx-env-view
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: "${USER_EMAIL}"
  namespace: jx
EOF
fi

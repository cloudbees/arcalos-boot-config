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
fi

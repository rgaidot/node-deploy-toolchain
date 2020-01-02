#!/bin/sh

eval `curl -H "X-Vault-Token: ${VAULT_TOKEN}" ${VAULT_URL} | jq -r '.data.data | to_entries | map("export \(.key)=\(.value);") | .[]'`
aws ecr get-login --no-include-email --region ${AWS_REGION}

exec "$@"

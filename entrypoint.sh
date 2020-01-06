#!/bin/sh

eval `curl -H "X-Vault-Token: ${VAULT_TOKEN}" ${VAULT_URL} | jq -r '.data.data | to_entries | map("export \(.key)=\(.value);") | .[]'`

curl -H "X-Vault-Token: ${VAULT_TOKEN}" ${VAULT_URL} | jq -r '.data.data | to_entries | map("\(.key)=\(.value)") | .[]' > /app/.env

aws ecr get-login --no-include-email --region ${AWS_REGION}

exec "$@"

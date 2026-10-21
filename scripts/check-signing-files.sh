#!/usr/bin/env sh
# Fails when Apple/Android signing material is tracked in git. This repo is
# public: certificates, provisioning profiles and keystores live in the
# owner's keychain / secret store, never in the tree.
set -eu
cd "$(dirname "$0")/.."
found=$(git ls-files | grep -iE '\.(mobileprovision|provisionprofile|cer|p12|p8|pem|key|jks|keystore)$|(^|/)key\.properties$' || true)
if [ -n "$found" ]; then
  echo "Signing material is tracked in git:" >&2
  echo "$found" >&2
  exit 1
fi
echo "OK: no signing material tracked."

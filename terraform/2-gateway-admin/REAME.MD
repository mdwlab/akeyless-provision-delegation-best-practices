
TF FAILED

akeyless gateway-create-allowed-access \
  -n cmdb_admin_gateway_access \
  --access-id p-xt99nqlag7dtam \
  -p targets,rotated_secret,rotate_secret_value \
  -u https://gw-condor.mdwlab.org \
  --profile default

CLI WORKS WITH ADMIN
 akeyless gateway-create-allowed-access \
>   -n cmdb_admin_gateway_access \
>   --access-id p-xt99nqlag7dtam \
>   -p targets,rotated_secret,rotate_secret_value \
>   -u https://gw-condor.mdwlab.org \
>   --profile default
{
  "id": 3496405,
  "name": "cmdb_admin_gateway_access",
  "description": "",
  "cluster_id": 63227,
  "access_id": "p-xt99nqlag7dtam",
  "sub_claims": null,
  "is_valid": true,
  "access_type": "api_key",
  "error": "",
  "editable": true,
  "permissions": [
    "targets",
    "rotated_secret",
    "rotate_secret_value"
  ],
  "created_at": "2026-08-07T02:39:26Z",
  "updated_at": "2026-08-07T02:39:26Z",
  "sub_claims_case_insensitive": false
}


akeyless gateway-create-allowed-access \
  -n cmdb_admin_gateway_access \
  --access-id p-xt99nqlag7dtam \
  -p targets,rotated_secret,rotate_secret_value \
  -u https://gw-condor.mdwlab.org \
  --profile tf_apikey

akeyless gateway-create-allowed-access \
>   -n cmdb_admin_gateway_access \
>   --access-id p-xt99nqlag7dtam \
>   -p targets,rotated_secret,rotate_secret_value \
>   -u https://gw-condor.mdwlab.org \
>   --profile tf_apikey
{
  "id": 3496418,
  "name": "cmdb_admin_gateway_access",
  "description": "",
  "cluster_id": 63227,
  "access_id": "p-xt99nqlag7dtam",
  "sub_claims": null,
  "is_valid": true,
  "access_type": "api_key",
  "error": "",
  "editable": true,
  "permissions": [
    "targets",
    "rotated_secret",
    "rotate_secret_value"
  ],
  "created_at": "2026-08-07T02:45:07Z",
  "updated_at": "2026-08-07T02:45:07Z",
  "sub_claims_case_insensitive": false
}

RESOLVED

Root cause: akeyless_api_gateway_address was missing the /api/v2 suffix.
Not a provider bug, not a permissions bug — the private gateway's data-plane
API lives at https://gw-condor.mdwlab.org/api/v2, not the bare host. Every
earlier symptom (auth "Missing required parameter - AccessId", 404s on
create, "unexpected end of JSON input" via AKEYLESS_GATEWAY_URL in the CLI)
was the same wrong-endpoint problem surfacing differently per client.

Fix: variables.tf default for akeyless_api_gateway_address is now
https://gw-condor.mdwlab.org/api/v2. Native akeyless_gateway_allowed_access
resource works fine once pointed at the right URL — no null_resource/CLI
workaround needed.

Applied for real:
- cmdb_admin_gateway_access: targets,rotated_secret,rotate_secret_value
- region_admin_gateway_access: targets,rotated_secret,rotate_secret_value
  (widened from targets-only to support 6-regional-admin-items)

GATEWAY IDENTITY'S OWN ROLE

Separate from the allowed-access grants above (which govern who can call
the gateway), the gateway's own identity — bound to cn_gateway_role in
1-global-admin — needs its own target-rule permissions:
- read: the gateway needs the target's stored credentials to make the
  actual database connection.
- update: on each scheduled rotation, the gateway writes the new
  credentials back onto the target.

cn_gateway_role already grants target-rule read/update (bundled into its
CRUDL rule on /xcorp/cn/*), so no role change was needed — noting this here
since it's easy to assume the allowed-access grant alone is sufficient.

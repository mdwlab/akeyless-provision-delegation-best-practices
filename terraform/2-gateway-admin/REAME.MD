
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

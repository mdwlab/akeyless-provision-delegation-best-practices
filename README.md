# akeyless-provision-delegation-best-practices

Terraform provisioning for the `/xcorp` path in Akeyless, mirroring the
console-built example structure — a delegated-admin model where each
persona gets its own credentials and only the permissions it needs, per
the account's Security Provision Best Practice doc.

## Structure

Each directory under `terraform/` is an independent root module with its
own state and provider credentials (the API-key auth method belonging to
that persona), run in this order:

| Dir | Persona | Creates |
|---|---|---|
| `1-global-admin` | account admin | region folders, `cn_cmdb_admin_role` / `cn_gateway_role` / `cn_region_admin_role`, and the `cmdb_admin`/`region_admin` API-key identities |
| `2-gateway-admin` | account admin | grants on the physical gateway's allowed-access list for `cmdb_admin` and `region_admin` (required before either can create targets/rotated secrets — see gotcha below) |
| `3-cmdb-admin-targets` | cmdb_admin | the `wayne_condor_postgres_target` and `condor_self_rotate_target` postgres targets |
| `4-cmdb-admin-items` | cmdb_admin | `condor_postgres_self_rs`, a self-rotating secret against `condor_self_rotate_target` |
| `5-regional-admin-auths` | region_admin | per-app-team roles/auth-methods (`app_team_c0001`, `app_team_c0002`) under `/xcorp/cn/teams` |
| `6-regional-admin-items` | region_admin | per-app-team rotated secrets (`condor_postgres_user_rs1`/`rs2`) against `wayne_condor_postgres_target` |

Each directory has a `terraform.tfvars.example` — copy to `terraform.tfvars`
and fill in real credentials/values (gitignored, never committed).

## Prerequisites

- Terraform >= 1.5
- `akeyless-community/akeyless` provider `~> 2.0`
- Each persona's access ID/key, sourced from the previous directory's
  `persona_credentials`/`rotated_secret_names` output — e.g. `2-gateway-admin`
  needs `1-global-admin`'s `terraform output -json persona_credentials`.

## Gotcha: private gateway endpoint

Targets and rotated secrets are gateway-mediated — creating them requires:

1. The calling identity to be on the physical gateway's allowed-access list
   (`2-gateway-admin`), and
2. The provider's `akeyless_api_gateway_address` to point at the gateway's
   **data-plane API**, which needs the `/api/v2` suffix:
   `https://gw-condor.mdwlab.org/api/v2` — not the bare host, and not the
   public `https://api.akeyless.io`.

Missing either produces confusing, unrelated-looking errors (`Missing
required parameter - AccessId`, `404 page not found`, `command is not
available on public gateway`) that all trace back to one of those two
causes. See `terraform/2-gateway-admin/REAME.MD` for the full debugging
trail.

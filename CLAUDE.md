# CLAUDE.md

Terraform for a delegated-admin model under `/xcorp` in Akeyless: each persona
authenticates with its own identity and holds only the RBAC it needs. See
`README.md` for the directory table and run order.

## Layout and conventions

- Each `terraform/N-*` dir is an **independent root module** with its own state
  and its own persona credentials. Run them in numeric order; later dirs consume
  earlier outputs (`terraform output -json persona_credentials`,
  `rotated_secret_names`).
- Paths are built as `${var.base_path}/${var.region}/...` (base `/xcorp`, region
  e.g. `cn`). Roles live at `${base}/${region}/${region}_<persona>_role`.
- Roles in `1-global-admin/roles.tf` are deliberately narrow (e.g. cmdb_admin's
  item-rule is `.../cmdb/*`, not the region wildcard). Keep new rules at the
  smallest path that works and comment why.
- `terraform.tfvars` is gitignored; update `terraform.tfvars.example` whenever
  you add a variable. Mark credentials `sensitive = true`.
- Provider: `akeyless-community/akeyless ~> 2.0`, Terraform >= 1.5.
- `github-workflow-tf-global-admin/` is a separate git repo that runs
  steps 1–2 in GitHub Actions via GitHub OIDC -> `akeyless auth --access-type jwt`
  -> `token_login` (no static Akeyless creds).

## Gateway gotcha (most common failure)

Gateway-mediated objects (targets, rotated secrets, gateway allowed-access,
event forwarders) need BOTH:

1. The calling identity on the gateway's allowed-access list (`2-gateway-admin`,
   cluster `63227`).
2. `akeyless_api_gateway_address = https://gw-condor.mdwlab.org/api/v2` — the
   private gateway **with** `/api/v2`, not the bare host and not api.akeyless.io.

Symptoms of getting this wrong look unrelated: `Missing required parameter -
AccessId`, `404 page not found`, `command is not available on public gateway`.
Full trail in `terraform/2-gateway-admin/REAME.MD`.

## Event forwarders

- RBAC: role needs the **Manage Event Forwarders** admin rule — scope is All, an
  explicit forwarder name, or a name template. Scoping is by **forwarder name,
  not item path**. Plain wildcards work: app-team roles in
  `5-regional-admin-auths` use `event_forwarders_name = ["app_team_<id>_*"]`.
- Provider/API quirks (verified on provider 2.0.5):
  - Names are only sent on **create-role**. An in-place update sends just
    `event_forwarders_access`, which becomes an `event-forwarder-rule` on `/*`
    (every forwarder). Change names with `-replace` on the role + its
    `akeyless_associate_role_auth_method`.
  - create-role rejects `event_forwarders_access` together with
    `event_forwarders_name` — set names only.
  - `set-role-rule --rule-type event-forwarder-rule` accepts only `all`/`own`.
  - Server stores names with a leading `/`, and the provider doesn't detect a
    missing rule, so plans can look clean while the server differs. Hence
    `ignore_changes`; verify with `get-role` (`.rules.path_rules`).
  - region_admin was given `event_center_access`/`event_forwarders_access` in
    `1-global-admin` after a 401 when it set these on app-team roles.
- Gateway: identity also needs the `event_forwarding` allowed-access permission.
- Event Center "Own"/scoped view only controls which events a role can *see*.
- Forwarders are not items in the tree (`list-items` has no forwarder type); a
  path-style name (`/xcorp/cn/app/c001_ef`) is unverified and would not inherit
  folder RBAC. Prefer flat prefixes like `xcorp-cn-c0001-ef`.
- Open question: whether a delegated user can point a forwarder at a source path
  (`--items-event-source-locations`) outside their own item permissions.
- Planned: `event_forwarding` grant in `2-gateway-admin`, and a region_admin step creating a forwarder for
  `/xcorp/cn/teams/*` to test the above.

## Useful checks

- SaaS health: `curl -s https://status.akeyless.io/api/v2/status.json | jq -r .status.indicator`
  (`none` = OK; per-component status at `/api/v2/components.json`).

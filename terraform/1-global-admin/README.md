terraform output -json persona_credentials

GATEWAY IDENTITY'S OWN ROLE

Separate from the allowed-access grants above (which govern who can call the gateway), the gateway's own identity — bound to cn_gateway_role in 1-global-admin — needs its own target-rule permissions:

read: e.g. the gateway needs the target's stored credentials to make the actual database connection.
update: e.g. on each scheduled rotation, the gateway writes the new credentials back onto the target.
cn_gateway_role already grants target-rule read/update (bundled into its CRUDL rule on /xcorp/cn/*), so no role change was needed — noting this here since it's easy to assume the allowed-access grant alone is sufficient.

locals {
    provision_id = try(var.oneform_tags["provision_id"], "")

    # Human-readable alias -> Arsys datacenter ID.
    # To discover datacenter IDs: curl -s -H "X-TOKEN: <token>" https://api.cloudbuilder.es/v1/datacenters
    registered_datacenter = jsondecode(file("${path.module}/data/datacenters.json"))

    resolved_datacenter_id = local.registered_datacenter[var.datacenter]
}

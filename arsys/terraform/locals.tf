locals {
    provision_id = try(var.oneform_tags["provision_id"], "")

    datacenters       = jsondecode(file("${path.module}/data/datacenters.json"))
    instance_types    = jsondecode(file("${path.module}/data/instance_types.json"))
    operating_systems = jsondecode(file("${path.module}/data/operating_systems.json"))

    resolved_datacenter_id       = local.datacenters[var.datacenter]
    resolved_instance_type_id    = local.instance_types[var.type]
    resolved_operating_system_id = local.operating_systems[var.operating_system]
}

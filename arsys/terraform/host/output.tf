output "id" {
    value = [for instance in arsys-baremetal_server.host : instance.id]
}

output "public_ip" {
    value = [for s in arsys-baremetal_server.host : [for ip in s.ips : ip.ip if ip.main][0]]
}

# Available baremetal models in this Arsys account.
# Use the 'id' value as var.instance_type when provisioning.
output "available_baremetal_models" {
    value = [for m in data.arsys-baremetal_baremetal_models.available.baremetal_models : {
        id    = m.id
        name  = m.name
        state = m.state
    }]
}

# OS appliances available in this datacenter.
# Use the 'id' value as var.instance_os_name when provisioning.
output "available_appliances" {
    value = [for a in data.arsys-baremetal_server_appliances.available.server_appliances : {
        id         = a.id
        name       = a.name
        os         = a.os
        os_version = a.os_version
    } if contains(a.available_datacenters, var.datacenter_id)]
}

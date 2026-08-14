output "provisioned_hosts" {
    value = [
        for idx in range(length(module.host.id)) : {
            instance_id = module.host.id[idx]
            instance_ip = module.host.public_ip[idx]
        }
    ]
}

# Baremetal models available in this Arsys account.
# Use the 'id' value as var.instance_type when creating a provision.
output "available_baremetal_models" {
    description = "Available baremetal models. Use 'id' as the instance_type value."
    value       = module.host.available_baremetal_models
}

# OS appliances available in the selected datacenter.
# Use the 'id' value as var.instance_os_name when creating a provision.
output "available_appliances" {
    description = "Available OS appliances in the selected datacenter. Use 'id' as the instance_os_name value."
    value       = module.host.available_appliances
}

output "firewall_policy_id" {
    value = arsys-baremetal_firewall_policy.cluster_fw.id
}

output "private_network_id" {
    value = arsys-baremetal_private_network.cluster_net.id
}

output "public_network_id" {
    value = arsys-baremetal_public_network.cluster_pub.id
}

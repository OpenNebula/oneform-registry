# Firewall policy - allow all traffic (equivalent to AWS security group open)
resource "arsys-baremetal_firewall_policy" "cluster_fw" {
  name        = "provision_${var.provision_id}_fw_${var.key_suffix}"
  description = "Allow all traffic for provision ${var.provision_id}"

  rules = [
    {
      protocol    = "ANY"
      port_from   = null
      port_to     = null
      source      = "0.0.0.0"
      description = "Allow all traffic"
      action      = "ALLOW"
    }
  ]
}

# Private network for internal cluster communication (Layer 2)
resource "arsys-baremetal_private_network" "cluster_net" {
  name            = "provision_${var.provision_id}_private_${var.key_suffix}"
  description     = "Internal network for provision ${var.provision_id}"
  datacenter_id   = var.datacenter_id
  network_address = cidrhost(var.cidr_block, 0)
  subnet_mask     = cidrnetmask(var.cidr_block)
}

# Public network — routes elastic/public traffic for cluster nodes
resource "arsys-baremetal_public_network" "cluster_pub" {
  public_name   = "provision_${var.provision_id}_pub_${var.key_suffix}"
  description   = "Public network for provision ${var.provision_id}"
  datacenter_id = var.datacenter_id
}

# /27 subnet block for elastic IP assignments (30 usable IPs).
# Note: description is intentionally omitted — the provider has a bug where it sends
# description in the request but the API returns null, causing an inconsistency error.
resource "arsys-baremetal_subnet" "cluster_subnet" {
  mask          = 28
  datacenter_id = var.datacenter_id
}

# TODO: Pending fix in Arsys API — GET /public_networks/{id}/ips returns 500.
# The assignment works correctly but the provider fails reading the final state.
# Uncomment once the provider is updated to use GET /public_networks/{id} instead.
# resource "arsys-baremetal_public_network_ips" "cluster_subnet_assign" {
#   public_network_id = arsys-baremetal_public_network.cluster_pub.id
#   action            = true
#   ips               = [arsys-baremetal_subnet.cluster_subnet.id]
# }

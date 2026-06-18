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

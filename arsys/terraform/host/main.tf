# Upload the oneadmin SSH public key (account-level resource, no datacenter_id).
resource "arsys-baremetal_ssh_key" "oneadmin" {
  name       = "provision_${var.provision_id}_oneadmin"
  public_key = local.oneadmin_pubkey
}

# Server creation with cloud-init -- the patched provider supports user_data
# and user_data_content_type, which passes cloud-init config to the Arsys API.
# This ensures SSH is enabled and the oneform user is created on first boot.
resource "arsys-baremetal_server" "host" {
  count              = var.oneform_hosts
  name               = "provision_${var.provision_id}_host_${count.index}"
  datacenter_id      = var.datacenter_id
  appliance_id       = local.registered_operating_system[var.operating_system]
  firewall_policy_id = var.firewall_policy_id
  public_key         = [arsys-baremetal_ssh_key.oneadmin.id]
  power_on           = true

  hardware = {
    baremetal_model_id = local.registered_type[var.type]
  }

  user_data              = local.cloud_config
  user_data_content_type = "yaml"
}

# Assign servers to networks sequentially -- Arsys does not handle concurrent
# network operations on the same server reliably, so we chain them:
# server -> private network -> public network

# Step 1: private network
resource "arsys-baremetal_private_network_servers_assign" "internal_assign" {
  id      = var.private_network_id
  servers = toset([for s in arsys-baremetal_server.host : s.id])

  depends_on = [arsys-baremetal_server.host]
}

# Step 2: public network (waits for private to finish)
resource "arsys-baremetal_public_network_servers" "public_assign" {
  public_network_id = var.public_network_id
  servers           = [for s in arsys-baremetal_server.host : s.id]

  depends_on = [arsys-baremetal_private_network_servers_assign.internal_assign]
}

resource "random_id" "key_suffix" {
    byte_length = 6
    keepers = {
        provision_id = local.provision_id
    }
}

module "cluster" {
    source        = "./cluster"
    provision_id  = local.provision_id
    key_suffix    = random_id.key_suffix.hex
    cidr_block    = var.cidr_block
    datacenter_id = local.resolved_datacenter_id
}

module "host" {
    source       = "./host"
    provision_id = local.provision_id
    key_suffix   = random_id.key_suffix.hex

    oneform_hosts    = var.oneform_hosts
    operating_system = var.operating_system
    type             = var.type
    datacenter_id    = local.resolved_datacenter_id

    firewall_policy_id = module.cluster.firewall_policy_id
    private_network_id = module.cluster.private_network_id
    public_network_id  = module.cluster.public_network_id
}

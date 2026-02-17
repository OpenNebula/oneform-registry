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
    scaleway_tags = var.oneform_tags
}

module "host" {
    source       = "./host"
    provision_id = local.provision_id
    key_suffix   = random_id.key_suffix.hex

    oneform_hosts    = var.oneform_hosts
    instance_os_name = var.instance_os_name
    instance_offer   = var.instance_type
    scaleway_tags    = var.oneform_tags
}

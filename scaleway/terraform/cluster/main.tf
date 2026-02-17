resource "scaleway_vpc" "scaleway_vpc_device" {
    name             = "provision_${var.provision_id}_vpc_${var.key_suffix}"
    enable_routing   = true
    tags             = [for key, value in var.scaleway_tags : "${key}=${value}"]
}

resource "scaleway_vpc_private_network" "scaleway_vpc_private_network_device" {
    name   = "provision_${var.provision_id}_private_network_${var.key_suffix}"
    vpc_id = scaleway_vpc.scaleway_vpc_device.id
    ipv4_subnet {
        subnet = var.cidr_block
    }
    tags  = [for key, value in var.scaleway_tags : "${key}=${value}"]
}

resource "scaleway_vpc_public_gateway" "scaleway_vpc_public_gateway_device" {
    name             = "provision_${var.provision_id}_internet_gateway_${var.key_suffix}"
    type             = "VPC-GW-S"
    bastion_enabled  = true
    bastion_port     = 61000
    tags             = [for key, value in var.scaleway_tags : "${key}=${value}"]

}

resource "scaleway_vpc_gateway_network" "scaleway_vpc_gateway_network_device" {
    gateway_id         = scaleway_vpc_public_gateway.scaleway_vpc_public_gateway_device.id
    private_network_id = scaleway_vpc_private_network.scaleway_vpc_private_network_device.id
    ipam_config {
        push_default_route = true
    }
}

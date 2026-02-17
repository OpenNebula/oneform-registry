resource "i3dnet_ssh_key" "oneadmin_pubkey" {
    name       = "provision_${var.provision_id}_key_${var.key_suffix}"
    public_key = trimspace(file(pathexpand("~/.ssh/id_rsa.pub")))
}

resource "i3dnet_flexmetal_server" "host" {
    count         = var.oneform_hosts
    name          = "provision-${var.provision_id}-host-${count.index}"
    location      = var.i3dnet_region
    instance_type = var.instance_type
    ssh_key       = [i3dnet_ssh_key.oneadmin_pubkey.public_key]

    os = {
        slug = var.instance_os_name
    }

    tags = [for key, value in var.i3dnet_tags : "${key}:${value}"]
}

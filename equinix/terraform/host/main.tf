resource "random_id" "key_suffix" {
    byte_length = 6
    keepers = {
        provision_id = var.provision_id
    }
}

resource "equinix_metal_ssh_key" "oneadmin_pubkey" {
    name       = "provision-${var.provision_id}-${random_id.key_suffix.id}"
    public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

resource "equinix_metal_device" "host" {
    count            = var.oneform_hosts
    hostname         = "provision-${var.provision_id}-host-${count.index}"
    plan             = var.instance_type
    metro            = var.equinix_region
    operating_system = var.instance_os_name
    project_id       = var.equinix_project_id
    billing_cycle    = "hourly"
    tags             = [for key, value in var.equinix_tags : "${key}=${value}"]
    depends_on       = [equinix_metal_ssh_key.oneadmin_pubkey]
}
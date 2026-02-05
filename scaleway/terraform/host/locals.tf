resource "random_id" "key_suffix" {
    byte_length = 6
    keepers = {
        provision_id = var.provision_id
    }
}

locals {
    registred_instance_os_name = {
        "ubuntu_2204" = data.scaleway_baremetal_os.ubuntu_2204
        "ubuntu_2404" = data.scaleway_baremetal_os.ubuntu_2404
    }

    instance_offer = {
        "em_a116x_ssd" = data.scaleway_baremetal_offer.em_a116x_ssd
    }
}

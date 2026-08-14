locals {
  oneadmin_pubkey = trimspace(file(pathexpand("~/.ssh/id_rsa.pub")))

  cloud_config = "#cloud-config"
}

resource "random_id" "key_suffix" {
    byte_length = 6
    keepers = {
        provision_id = var.provision_id
    }
}

locals {
	registred_instance_os_name = {
		"ubuntu_2204" = data.aws_ami.ubuntu_2204.id
		"ubuntu_2004" = data.aws_ami.ubuntu_2004.id
	}
}

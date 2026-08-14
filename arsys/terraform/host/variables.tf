variable "oneform_hosts" {
    description = "Number of instances to create"
    type        = number
}

variable "operating_system" {
    description = "Operating system to use for the instance"
    type        = string
}

variable "type" {
    description = "Arsys baremetal model name"
    type        = string
}

variable "datacenter_id" {
    description = "Arsys datacenter ID"
    type        = string
}

variable "provision_id" {
    description = "Provision ID for the host"
}

variable "firewall_policy_id" {
    description = "ID of the firewall policy to assign to the servers"
    type        = string
}

variable "private_network_id" {
    description = "ID of the private network to attach the servers to"
    type        = string
}

variable "public_network_id" {
    description = "ID of the public network to attach the servers to"
    type        = string
}

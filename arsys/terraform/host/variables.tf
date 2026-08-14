variable "oneform_hosts" {
    description = "Number of instances to create"
    type        = number
}

variable "appliance_id" {
    description = "Arsys appliance ID"
    type        = string
}

variable "baremetal_model_id" {
    description = "Arsys baremetal model ID"
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

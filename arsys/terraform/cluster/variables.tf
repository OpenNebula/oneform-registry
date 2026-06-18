variable "provision_id" {
    description = "Provision ID for the cluster"
}

variable "key_suffix" {
    description = "Suffix name for resource names"
    type        = string
}

variable "cidr_block" {
    description = "CIDR block for the private network"
    type        = string
    default     = "192.168.100.0/24"
}

variable "datacenter_id" {
    description = "Arsys datacenter ID"
    type        = string
}


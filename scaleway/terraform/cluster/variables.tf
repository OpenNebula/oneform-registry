variable "cidr_block" {
    description = "CIDR block for the VPC"
    type = string
}

variable "scaleway_tags" {
    description = "Tags for Scaleway resources"
    type = map(string)
}

variable "key_suffix" {
    description = "Suffix name for resource names"
    type        = string
}

variable "provision_id" {
    description = "Provision ID for the host"
}
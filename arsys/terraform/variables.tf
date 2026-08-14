variable "oneform_hosts" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "type" {
  description = "Baremetal model alias (see validators.tf for options, or run 'terraform output available_baremetal_models' to discover new ones)"
  type        = string
  default     = "AMD Ryzen 5 Pro 3600 (6 cores - 32GB RAM - 2000GB HDD)"
}

variable "operating_system" {
  description = "OS appliance alias (see validators.tf for options, or run 'terraform output available_appliances' to discover new ones)"
  type        = string
  default     = "Ubuntu 24.04"
}

variable "cidr_block" {
  description = "CIDR block for the private network"
  type        = string
  default     = "192.168.100.0/24"
}

variable "oneform_tags" {
  description = "Tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "oneform_hosts" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "type" {
  description = "Baremetal model alias"
  type        = string
  default     = "AMD Ryzen 5 Pro 3600 (6 cores - 32GB RAM - 2000GB HDD)"
}

variable "operating_system" {
  description = "OS appliance alias"
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

terraform {
  required_providers {
    arsys-baremetal = {
      source  = "arsys-internet/arsys-baremetal"
      version = "~> 0.1"
    }
  }
}

variable "token" {
  type        = string
  sensitive   = true
  description = "Arsys API token"
}

variable "datacenter" {
  description = "Arsys datacenter alias (see validators.tf for options)"
  type        = string
  default     = "Spain"
}

provider "arsys-baremetal" {
  token = var.token
  host  = "https://api.cloudbuilder.es/v1"
}

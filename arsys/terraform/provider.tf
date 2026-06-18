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

provider "arsys-baremetal" {
  token = var.token
  host  = "https://api.cloudbuilder.es/v1"
}

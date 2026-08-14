terraform {
    required_providers {
        arsys-baremetal = {
            source  = "arsys-internet/arsys-baremetal"
            version = "~> 0.1"
        }
        null = {
            source  = "hashicorp/null"
            version = "~> 3.0"
        }
    }
}

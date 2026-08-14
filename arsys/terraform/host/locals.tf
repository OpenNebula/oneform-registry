locals {
  oneadmin_pubkey = trimspace(file(pathexpand("~/.ssh/id_rsa.pub")))

  cloud_config = "#cloud-config"

  # Human-readable alias -> baremetal model ID.
  # Add new model aliases here and to validators.tf type values.
  registered_type = {
    "AMD Ryzen 5 Pro 3600 (6 cores - 32GB RAM - 2000GB HDD)"         = "6C69A7955D32C8A32ECC484AF803BA7A"
    "Intel Xeon E3-1230 v6 SSD (4 cores - 16GB RAM - 960GB SSD)"     = "C598EAD5691CDADD1501A2AF29A2E91C"
    "AMD Epyc 7302P (16 cores - 128GB RAM - 8000GB HDD)"             = "77E2B212161F1B249353624415CE1B53"
    "Intel Xeon Silver 4123 HDD (8 cores - 96GB RAM - 8000GB HDD)"   = "B5A8AFAB75C5FF432B5E1B540C9B5D16"
    "Intel Xeon Silver 4123 NVMe (8 cores - 96GB RAM - 2000GB NVMe)" = "5A3C0BF493B06818B782C34280DC46DE"
    "Intel Xeon Gold 6126 HDD (12 cores - 192GB RAM - 8000GB HDD)"   = "2F5FD280FD9CEE57AADDFD61CA94B88A"
    "Intel Xeon Gold 6126 NVMe (12 cores - 192GB RAM - 2000GB NVMe)" = "8E3BAA98E3DFD37857810E0288DD8FBA"
    "AMD Epyc 7543P (32 cores - 256GB RAM - 16000GB HDD)"            = "601A9D626B9524F3121525F289B0CA15"
  }

  # Human-readable alias -> appliance ID.
  # Add new OS aliases here and to validators.tf operating_system values.
  registered_operating_system = {
    "Ubuntu 24.04" = "5D3BBD43E3AB7E8884753025F70DF294"
  }
}

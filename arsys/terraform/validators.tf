locals {
    # Arsys provider validators - these values appear as dropdown options in FireEdge.
    #
    # To add a new model or appliance:
    #   1. Get its ID from the Arsys API
    #   2. Add an alias -> ID entry to registered_type or registered_operating_system
    #      in host/locals.tf
    #   3. Add the alias string to the values list below
    #
    # Datacenter aliases are generated from data/datacenters.json. After updating it, run:
    #   ruby arsys/scripts/generate_datacenter_validators.rb
    validators = {
        datacenter = {
            type   = "list"
            # BEGIN GENERATED DATACENTERS
            values = ["France", "Germany north", "Germany south", "Spain", "United Kingdom", "United States"]
            # END GENERATED DATACENTERS
        }

        type = {
            type   = "list"
            values = [
                "AMD Ryzen 5 Pro 3600 (6 cores - 32GB RAM - 2000GB HDD)",
                "Intel Xeon E3-1230 v6 SSD (4 cores - 16GB RAM - 960GB SSD)",
                "AMD Epyc 7302P (16 cores - 128GB RAM - 8000GB HDD)",
                "Intel Xeon Silver 4123 HDD (8 cores - 96GB RAM - 8000GB HDD)",
                "Intel Xeon Silver 4123 NVMe (8 cores - 96GB RAM - 2000GB NVMe)",
                "Intel Xeon Gold 6126 HDD (12 cores - 192GB RAM - 8000GB HDD)",
                "Intel Xeon Gold 6126 NVMe (12 cores - 192GB RAM - 2000GB NVMe)",
                "AMD Epyc 7543P (32 cores - 256GB RAM - 16000GB HDD)"
            ]
        }

        operating_system = {
            type   = "list"
            values = ["Ubuntu 24.04"]
        }
    }
}

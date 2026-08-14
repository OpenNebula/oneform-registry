locals {
    provision_id = try(var.oneform_tags["provision_id"], "")

    # Human-readable alias → Arsys datacenter ID.
    # To discover datacenter IDs: curl -s -H "X-TOKEN: <token>" https://api.cloudbuilder.es/v1/datacenters
    # Add the alias to validators.tf datacenter_id values when adding new entries.
    registered_datacenter = {
        "Spain"         = "81DEF28500FBC2A973FC0C620DF5B721"
        "Germany south" = "4EFAD5836CE43ACA502FD5B99BEE44EF"
        "Germany north" = "9B94281B5B67A755F2B76165E25F6A65"
        "United Kingdom"            = "5091F6D8CBFEF9C26ACE957C652D5D49"
        "United States"            = "908DC2072407C94C8054610AD5A53B8C"
        "France"        = "E3F9C6BC7DF66F804F4EE7F2F0F7A0F6"
    }

    # Resolve alias to actual ID (pass through raw IDs for backwards compatibility)
    resolved_datacenter_id = lookup(local.registered_datacenter, var.datacenter, var.datacenter)
}

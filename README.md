# oneform-registry
Registry of OneForm provider drivers for provisioning OpenNebula clusters across multiple cloud and infrastructure providers.

## Repository Structure
Each directory in this repository represents a OneForm provider driver and follows a standardized layout that defines how infrastructure is provisioned, configured, and integrated with OpenNebula:

```
<driver>/
├── ansible/
├── elastic/
├── ipam/
├── terraform/
└── driver.conf
```

* `ansible/`: Ansible inventories, playbooks, templates, and roles used to configure provisioned hosts. Typically used for SSH setup, firewall rules, networking configuration, and cluster bootstrap tasks.

* `elastic/`: Elastic networking drivers (optional). Contains provider-specific implementations for floating/public IP management and virtual networking integration.

* `ipam/`: IP Address Management (IPAM) scripts (optional). Implements allocation, release, and lifecycle operations for IP address ranges managed by OpenNebula.

* `terraform/`: Terraform modules used to provision infrastructure resources on the target provider.
Includes host provisioning, cluster resources, networking, and validation logic.

* `driver.conf`: Provider driver configuration file. Defines provider metadata, capabilities, and integration parameters used by OneForm.

For more details on the OneForm driver structure, please refer to the official OpenNebula documentation.

## Installation
To install and use these drivers, **OpenNebula OneForm (available in OpenNebula 7.2 or later)** is required.

OneForm uses a dedicated directory to load external provider registries into the OneForm driver system:

```text
/var/lib/one/oneform/drivers
 ├── oneform-registry/
 │   └── ...
 └── other-sources/
     └── ...
```

### Steps

1. Clone this repository into the OneForm external drivers directory as the `oneadmin` user:

    ```bash
    git -C /var/lib/one/oneform/drivers clone https://github.com/OpenNebula/oneform-registry.git
    ```

2. Checkout the release according to your OpenNebula version, for example to use the registry with OpenNebula 7.2 use the latest 7.2 release:
   ```bash
   git checkout release-7.2.0
   ```

2. Trigger a OneForm driver rescan:

    ```bash
    oneform sync
    ```

    After synchronization, OneForm will automatically detect the new providers and add them to the available driver catalog. You can check that running the `oneform list` command.

## How to Contribute
A detailed guide on how to develop and extend new OneForm provider drivers is available in the official OpenNebula documentation.

You can also discuss ideas, ask questions, and share feedback in the official [OpenNebula Community Forums](https://forum.opennebula.io/).

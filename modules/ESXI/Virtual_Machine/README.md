## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_esxi"></a> [esxi](#provider\_esxi) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| esxi_guest.guest | resource |
| esxi_resource_pool.resource_pool | resource |
| esxi_virtual_disk.virtual_disk | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_guest"></a> [guest](#input\_guest) | n/a | <pre>map(object({<br>      boot_disk_type = optional(string)<br>      boot_disk_size = optional(number)<br>      guestos = optional(string)<br>      boot_firmware = optional(string)<br>      clone_from_vm = optional(string)<br>      disk_store = string<br>      resource_pool_name = optional(string)<br>      memsize = optional(number)<br>      numvcpus = optional(number)<br>      network_interfaces = optional(object({<br>        virtual_network = string<br>        mac_address = optional(string)<br>        nic_type = optional(string)<br>      }))<br>      virtual_disks = optional(object({<br>        virtual_disk_id = string<br>        slot = string<br>      }))<br>    }))</pre> | n/a | yes |
| <a name="input_resource_pool"></a> [resource\_pool](#input\_resource\_pool) | n/a | <pre>map(object({<br>      cpu_min = optional(number)<br>      cpu_max = optional(number)<br>      cpu_max_shares = optional(number)<br>      mem_min = optional(number)<br>      mem_max = optional(number)<br>      mem_shares = optional(number)<br>    }))</pre> | n/a | yes |
| <a name="input_virtual_disk"></a> [virtual\_disk](#input\_virtual\_disk) | n/a | <pre>map(object({<br>      virtual_disk_disk_store = string<br>      virtual_disk_dir = string<br>      virtual_disk_size = optional(number)<br>      virtual_disk_type = optional(string)<br>    }))</pre> | n/a | yes |

## Outputs

No outputs.

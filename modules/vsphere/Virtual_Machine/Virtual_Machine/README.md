## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vsphere"></a> [vsphere](#requirement\_vsphere) | 2.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | 2.3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_virtual_machine.virtual_machine](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/virtual_machine) | resource |
| [vsphere_datacenter.datacenter](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/datacenter) | data source |
| [vsphere_datastore.datastore](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/datastore) | data source |
| [vsphere_datastore_cluster.datastore_cluster](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/datastore_cluster) | data source |
| [vsphere_folder.folder](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/folder) | data source |
| [vsphere_network.network](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/network) | data source |
| [vsphere_resource_pool.resource_pool](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/resource_pool) | data source |
| [vsphere_storage_policy.storage_policy](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/storage_policy) | data source |
| [vsphere_tag.tag](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/tag) | data source |
| [vsphere_tag_category.tag_category](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/tag_category) | data source |
| [vsphere_virtual_machine.template](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/virtual_machine) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Administrator password for Windows virtual machine | `string` | `null` | no |
| <a name="input_clone"></a> [clone](#input\_clone) | n/a | <pre>object({<br>    network_address = string<br>    netmask         = number<br>  })</pre> | n/a | yes |
| <a name="input_custom_attributes"></a> [custom\_attributes](#input\_custom\_attributes) | n/a | `map(any)` | `null` | no |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | Name of the datacenter | `string` | `""` | no |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | Name of the datastore to deploy the virtual machine | `string` | `""` | no |
| <a name="input_datastore_cluster"></a> [datastore\_cluster](#input\_datastore\_cluster) | Name of the datastore cluster to deploy the virtual machine | `string` | `""` | no |
| <a name="input_disk"></a> [disk](#input\_disk) | n/a | <pre>map(object({<br>    size             = optional(number)<br>    unit_number      = optional(number)<br>    thin_provisioned = optional(bool)<br>    eagerly_scrub    = optional(bool)<br>    io_reservation   = optional(number)<br>    io_share_level   = optional(string)<br>    io_share_count   = optional(string)<br>    disk_sharing     = optional(string)<br>    disk_mode        = optional(string)<br>    controller_type  = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_dns_server_list"></a> [dns\_server\_list](#input\_dns\_server\_list) | n/a | `list(string)` | `null` | no |
| <a name="input_dns_suffix_list"></a> [dns\_suffix\_list](#input\_dns\_suffix\_list) | A list of DNS search domains to add to the DNS configuration on the virtual machine | `list(string)` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_extra_config"></a> [extra\_config](#input\_extra\_config) | Extra configuration data for this virtual machine | `map(any)` | `null` | no |
| <a name="input_folder"></a> [folder](#input\_folder) | Name of the folder in which the virtual machine will be stored | `string` | `null` | no |
| <a name="input_general_options"></a> [general\_options](#input\_general\_options) | n/a | <pre>object({<br>    scsi_controller       = optional(number)<br>    firmware              = optional(string)<br>    memory                = optional(number)<br>    num_cpus              = optional(number)<br>    num_cores_per_socket  = optional(number)<br>    cpu_share_level       = optional(string)<br>    cpu_share_count       = optional(number)<br>    cpu_limit             = optional(number)<br>    cpu_reservation       = optional(number)<br>    memory_limit          = optional(number)<br>    memory_reservation    = optional(number)<br>    memory_share_count    = optional(number)<br>    memory_share_level    = optional(string)<br>    ignored_guest_ips     = list(string)<br>    hv_mode               = optional(string)<br>    ept_rvi_mode          = optional(string)<br>    latency_sensitivity   = optional(string)<br>    swap_placement_policy = optional(string)<br>    scsi_bus_sharing      = optional(string)<br>    scsi_type             = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_instances"></a> [instances](#input\_instances) | Number of virtual machine needed to be deployed | `number` | `1` | no |
| <a name="input_ipv4_gateway"></a> [ipv4\_gateway](#input\_ipv4\_gateway) | Virtual Machine Gateway to set | `any` | `null` | no |
| <a name="input_linux"></a> [linux](#input\_linux) | n/a | `bool` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | n/a | `map(list(string))` | `{}` | no |
| <a name="input_resource_pool"></a> [resource\_pool](#input\_resource\_pool) | Resource pool on which the virtual machine will be deployed | `string` | n/a | yes |
| <a name="input_storage_policy"></a> [storage\_policy](#input\_storage\_policy) | The storage policy to be sassigned to the virtual machine home directory | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The name of the tags to attach to the resource | `map(any)` | `null` | no |
| <a name="input_tags_ids"></a> [tags\_ids](#input\_tags\_ids) | The ids of the tags to attache to the resource | `list(any)` | `null` | no |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | Name of the template for the VM to be deployed | `string` | `""` | no |
| <a name="input_vmname"></a> [vmname](#input\_vmname) | The name of the virtual machine used to deploy | `string` | n/a | yes |
| <a name="input_windows"></a> [windows](#input\_windows) | n/a | `bool` | n/a | yes |
| <a name="input_workgroup"></a> [workgroup](#input\_workgroup) | Workgroup of the Windows virtual machine | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | n/a |

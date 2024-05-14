## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.3 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | 1.54.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | 1.54.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [openstack_dns_recordset_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/dns_recordset_v2) | resource |
| [openstack_dns_transfer_accept_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/dns_transfer_accept_v2) | resource |
| [openstack_dns_transfer_request_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/dns_transfer_request_v2) | resource |
| [openstack_dns_zone_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/dns_zone_v2) | resource |
| [openstack_identity_project_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/data-sources/identity_project_v3) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_recordset_v2"></a> [recordset\_v2](#input\_recordset\_v2) | The following arguments are supported:<br>region - (Optional) The region in which to obtain the V2 DNS client. If omitted, the region argument of the provider is used. Changing this creates a new DNS record set.<br>zone\_id - (Required) The ID of the zone in which to create the record set. Changing this creates a new DNS record set.<br>name - (Required) The name of the record set. Note the . at the end of the name. Changing this creates a new DNS record set.<br>project\_id - (Optional) The ID of the project DNS zone is created for, sets X-Auth-Sudo-Tenant-ID header (requires an assigned user role in target project)<br>type - (Optional) The type of record set. Examples: "A", "MX". Changing this creates a new DNS record set.<br>ttl - (Optional) The time to live (TTL) of the record set.<br>description - (Optional) A description of the record set.<br>records - (Required) An array of DNS records.<br>value\_specs - (Optional) Map of additional options. Changing this creates a new record set.<br>disable\_status\_check - (Optional) Disable wait for recordset to reach ACTIVE status. This argumen is disabled by default. If it is set to true, the recordset will be considered as created/updated/deleted if OpenStack request returned success. | <pre>list(map(object({<br>    id                   = number<br>    name                 = string<br>    records              = list(string)<br>    zone_id              = number<br>    type                 = optional(string)<br>    ttl                  = optional(number)<br>    description          = optional(string)<br>    value_specs          = optional(map(string))<br>    disable_status_check = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_transfer_accept_v2"></a> [transfer\_accept\_v2](#input\_transfer\_accept\_v2) | The following arguments are supported:<br>region - (Optional) The region in which to obtain the V2 Compute client. Keypairs are associated with accounts, but a Compute client is needed to create one. If omitted, the region argument of the provider is used. Changing this creates a new DNS zone.<br>zone\_transfer\_request\_id - (Required) The ID of the zone transfer request.<br>key - (Required) The transfer key.<br>value\_specs - (Optional) Map of additional options. Changing this creates a new transfer accept.<br>disable\_status\_check - (Optional) Disable wait for zone to reach ACTIVE status. The check is enabled by default. If this argument is true, zone will be considered as created/updated if OpenStack accept returned success. | <pre>list(map(object({<br>    id                   = number<br>    zone_id              = number<br>    value_specs          = optional(map(string))<br>    disable_status_check = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_transfer_request_v2"></a> [transfer\_request\_v2](#input\_transfer\_request\_v2) | The following arguments are supported:<br>region - (Optional) The region in which to obtain the V2 Compute client. Keypairs are associated with accounts, but a Compute client is needed to create one. If omitted, the region argument of the provider is used. Changing this creates a new DNS zone.<br>zone\_id - (Required) The ID of the zone for which to create the transfer request.<br>target\_project\_id - (Optional) The target Project ID to transfer to.<br>description - (Optional) A description of the zone tranfer request.<br>value\_specs - (Optional) Map of additional options. Changing this creates a new transfer request.<br>disable\_status\_check - (Optional) Disable wait for zone to reach ACTIVE status. The check is enabled by default. If this argument is true, zone will be considered as created/updated if OpenStack request returned success. | <pre>list(map(object({<br>    id                   = number<br>    zone_id              = number<br>    target_project_id    = optional(number)<br>    description          = optional(string)<br>    value_specs          = optional(map(string))<br>    disable_status_check = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_zone_v2"></a> [zone\_v2](#input\_zone\_v2) | The following arguments are supported:<br>region - (Optional) The region in which to obtain the V2 Compute client. Keypairs are associated with accounts, but a Compute client is needed to create one. If omitted, the region argument of the provider is used. Changing this creates a new DNS zone.<br>name - (Required) The name of the zone. Note the . at the end of the name. Changing this creates a new DNS zone.<br>project\_id - (Optional) The ID of the project DNS zone is created for, sets X-Auth-Sudo-Tenant-ID header (requires an assigned user role in target project)<br>email - (Optional) The email contact for the zone record.<br>type - (Optional) The type of zone. Can either be PRIMARY or SECONDARY. Changing this creates a new zone.<br>attributes - (Optional) Attributes for the DNS Service scheduler. Changing this creates a new zone.<br>ttl - (Optional) The time to live (TTL) of the zone.<br>description - (Optional) A description of the zone.<br>masters - (Optional) An array of master DNS servers. For when type is SECONDARY.<br>value\_specs - (Optional) Map of additional options. Changing this creates a new zone.<br>disable\_status\_check - (Optional) Disable wait for zone to reach ACTIVE status. The check is enabled by default. If this argument is true, zone will be considered as created/updated if OpenStack request returned success. | <pre>list(map(object({<br>    id                   = number<br>    name                 = string<br>    email                = optional(string)<br>    type                 = optional(string)<br>    attributes           = optional(map(string))<br>    ttl                  = optional(number)<br>    description          = optional(string)<br>    masters              = optional(list(string))<br>    value_specs          = optional(map(string))<br>    disable_status_check = optional(bool)<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_recordset"></a> [recordset](#output\_recordset) | n/a |
| <a name="output_transfer_accept"></a> [transfer\_accept](#output\_transfer\_accept) | n/a |
| <a name="output_transfer_request"></a> [transfer\_request](#output\_transfer\_request) | n/a |
| <a name="output_zone"></a> [zone](#output\_zone) | n/a |

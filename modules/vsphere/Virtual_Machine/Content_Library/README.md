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
| [vsphere_content_library.publication](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/content_library) | resource |
| [vsphere_content_library.subscription](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/content_library) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | n/a | yes |
| <a name="input_publication"></a> [publication](#input\_publication) | Options to publish a local content library | <pre>map(object({<br>    description           = optional(string)<br>    storage_backing       = optional(list(string))<br>    authentication_method = optional(string)<br>    published             = optional(bool)<br>  }))</pre> | `{}` | no |
| <a name="input_subscription"></a> [subscription](#input\_subscription) | Options to subscribe to a published content library | <pre>map(object({<br>    description           = optional(string)<br>    storage_backing       = optional(list(string))<br>    subscription_url      = optional(string)<br>    authentication_method = optional(string)<br>    automatic_sync        = optional(bool)<br>    on_demand             = optional(bool)<br>  }))</pre> | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_content_library"></a> [content\_library](#output\_content\_library) | n/a |

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
| [vsphere_vapp_entity.vapp_entity](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/vapp_entity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_id"></a> [container\_id](#input\_container\_id) | n/a | `string` | n/a | yes |
| <a name="input_start"></a> [start](#input\_start) | n/a | <pre>object({<br>    action = optional(string)<br>    delay  = optional(number)<br>    order  = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_stop"></a> [stop](#input\_stop) | n/a | <pre>object({<br>    action = optional(string)<br>    delay  = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_target_id"></a> [target\_id](#input\_target\_id) | n/a | `string` | n/a | yes |
| <a name="input_wait_for_guest"></a> [wait\_for\_guest](#input\_wait\_for\_guest) | n/a | `bool` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_entity"></a> [entity](#output\_entity) | n/a |

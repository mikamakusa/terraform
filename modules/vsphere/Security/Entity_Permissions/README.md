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
| [vsphere_entity_permissions.entity_permission](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/entity_permissions) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_permission"></a> [permission](#input\_permission) | n/a | <pre>object({<br>    entity_id   = string<br>    entity_type = string<br>    permission = object({<br>      user_or_group = string<br>      propagate     = bool<br>      is_group      = bool<br>      role_id       = string<br>    })<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_entity_permission"></a> [entity\_permission](#output\_entity\_permission) | n/a |

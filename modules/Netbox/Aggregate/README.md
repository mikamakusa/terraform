## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_netbox"></a> [netbox](#requirement\_netbox) | 3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_netbox"></a> [netbox](#provider\_netbox) | 3.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [netbox_aggregate.aggregate](https://registry.terraform.io/providers/e-breuninger/netbox/3.2.0/docs/resources/aggregate) | resource |
| [netbox_rir.rir](https://registry.terraform.io/providers/e-breuninger/netbox/3.2.0/docs/resources/rir) | resource |
| [netbox_tenant.tenant](https://registry.terraform.io/providers/e-breuninger/netbox/3.2.0/docs/data-sources/tenant) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregate"></a> [aggregate](#input\_aggregate) | n/a | `any` | n/a | yes |
| <a name="input_rir"></a> [rir](#input\_rir) | n/a | `any` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aggregate_id"></a> [aggregate\_id](#output\_aggregate\_id) | n/a |
| <a name="output_rir_id"></a> [rir\_id](#output\_rir\_id) | n/a |

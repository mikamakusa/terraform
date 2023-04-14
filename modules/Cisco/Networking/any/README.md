## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | 2.6.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | 2.6.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aci_any.main](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/any) | resource |
| [aci_tenant.data_tenant](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/data-sources/tenant) | data source |
| [aci_vrf.data_vrf](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/data-sources/vrf) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotation"></a> [annotation](#input\_annotation) | Annotation of the ANY Object - Optional | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the ANY object - Optional | `string` | `null` | no |
| <a name="input_match_t"></a> [match\_t](#input\_match\_t) | Represents the provider label match criteria - Optional | `string` | `"AtleastOne"` | no |
| <a name="input_name_alias"></a> [name\_alias](#input\_name\_alias) | Name alias of the Any Object - Optional | `string` | `null` | no |
| <a name="input_pref_gr_memb"></a> [pref\_gr\_memb](#input\_pref\_gr\_memb) | Represents parameter used to determine if EPgs can be divided in a the context can be divided into two subgroups | `string` | `"disabled"` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Tenant name to recover the id for the vrf data source | `string` | n/a | yes |
| <a name="input_vrf_name"></a> [vrf\_name](#input\_vrf\_name) | Name of the object vrf - needed for the ACI Any object to be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aci_any_id"></a> [aci\_any\_id](#output\_aci\_any\_id) | n/a |

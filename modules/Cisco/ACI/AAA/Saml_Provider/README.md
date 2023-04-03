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
| [aci_saml_provider.saml_provider](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/saml_provider) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_saml_provider"></a> [saml\_provider](#input\_saml\_provider) | n/a | <pre>map(object({<br>    name_alias                      = optional(string)<br>    description                     = optional(string)<br>    annotation                      = optional(string)<br>    entity_id                       = optional(string)<br>    gui_banner_message              = optional(string)<br>    https_proxy                     = optional(string)<br>    id_p                            = optional(string)<br>    key                             = optional(string)<br>    metadata_url                    = optional(string)<br>    monitor_server                  = optional(string)<br>    monitoring_user                 = optional(string)<br>    monitoring_password             = optional(string)<br>    retries                         = optional(string)<br>    sig_alg                         = optional(string)<br>    timeout                         = optional(string)<br>    tp                              = optional(string)<br>    want_assertions_encrypted       = optional(string)<br>    want_assertions_signed          = optional(string)<br>    want_requests_signed            = optional(string)<br>    want_response_signed            = optional(string)<br>    relation_aaa_rs_prov_to_epp     = optional(string)<br>    relation_aaa_rs_sec_prov_to_epg = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_saml_provider_id"></a> [saml\_provider\_id](#output\_saml\_provider\_id) | n/a |

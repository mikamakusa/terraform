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
| [aci_local_user.local_user](https://registry.terraform.io/providers/ciscodevnet/aci/2.6.1/docs/resources/local_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_local_user"></a> [local\_user](#input\_local\_user) | Manages ACI Local User | <pre>map(object({<br>    account_status      = optional(string)<br>    annotation          = optional(string)<br>    cert_attribute      = optional(string)<br>    clear_pwd_history   = optional(string)<br>    description         = optional(string)<br>    email               = optional(string)<br>    expiration          = optional(string)<br>    expires             = optional(string)<br>    first_name          = optional(string)<br>    last_name           = optional(string)<br>    name_alias          = optional(string)<br>    otpenable           = optional(string)<br>    otpkey              = optional(string)<br>    phone               = optional(string)<br>    pwd                 = optional(string)<br>    pwd_life_time       = optional(string)<br>    pwd_update_required = optional(string)<br>    rbac_string         = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aci_local_user_id"></a> [aci\_local\_user\_id](#output\_aci\_local\_user\_id) | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.98.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.98.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cognitive_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.98.0/docs/resources/cognitive_account) | resource |
| [azurerm_cognitive_account_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.98.0/docs/resources/cognitive_account_customer_managed_key) | resource |
| [azurerm_cognitive_deployment.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.98.0/docs/resources/cognitive_deployment) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/3.98.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | Manages a Cognitive Services Account. | <pre>list(map(object({<br>    id                                           = number<br>    kind                                         = string<br>    name                                         = string<br>    sku                                          = string<br>    custom_question_answering_search_service_id  = optional(string)<br>    custom_subdomain_name                        = optional(string)<br>    custom_question_answering_search_service_key = optional(string)<br>    dynamic_throttling_enabled                   = optional(bool)<br>    fqdns                                        = optional(list(string))<br>    local_auth_enabled                           = optional(bool)<br>    metrics_advisor_aad_client_id                = optional(string)<br>    metrics_advisor_aad_tenant_id                = optional(string)<br>    metrics_advisor_super_user_name              = optional(string)<br>    metrics_advisor_website_name                 = optional(string)<br>    outbound_network_access_restricted           = optional(bool)<br>    public_network_access_enabled                = optional(bool)<br>    qna_runtime_endpoint                         = optional(string)<br>    tags                                         = optional(map(string))<br>    network_acls = optional(list(object({<br>      default_action = string<br>      ip_rules       = optional(list(string))<br>      virtual_network_rules = optional(list(object({<br>        subnet_id                            = string<br>        ignore_missing_vnet_service_endpoint = optional(bool)<br>      })), [])<br>    })), [])<br>    customer_managed_key = optional(list(object({<br>      key_vault_key_id   = string<br>      identity_client_id = optional(string)<br>    })), [])<br>    identity = optional(list(object({<br>      type         = string<br>      identity_ids = optional(list(string))<br>    })), [])<br>    storage = optional(list(object({<br>      storage_account_id = string<br>      identity_client_id = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_account_customer_managed_key"></a> [account\_customer\_managed\_key](#input\_account\_customer\_managed\_key) | n/a | <pre>list(map(object({<br>    id                   = number<br>    cognitive_account_id = number<br>    key_vault_key_id     = string<br>    identity_client_id   = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_deployment"></a> [deployment](#input\_deployment) | Manages a Cognitive Services Account Deployment.<br>cognitive\_account\_id - (Required) : The ID of the Cognitive Services Account<br>model / format - (Required) : The format of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created. Possible value is OpenAI<br>scale / type - (Required) : The name of the SKU. Ex - Standard or P3<br>scale / tier - (Required) : Possible values are Free, Basic, Standard, Premium, Enterprise<br>scale / capacity - (Optional) : Tokens-per-Minute (TPM). The unit of measure for this field is in the thousands of Tokens-per-Minute. Defaults to 1 which means that the limitation is 1000 tokens per minute. If the resources SKU supports scale in/out then the capacity field should be included in the resources' configuration. | <pre>list(map(object({<br>    id                   = number<br>    cognitive_account_id = number<br>    name                 = string<br>    rai_policy_name      = optional(string)<br>    model = list(object({<br>      format  = string<br>      name    = string<br>      version = string<br>    }))<br>    scale = list(object({<br>      type     = string<br>      tier     = string<br>      size     = string<br>      family   = optional(string)<br>      capacity = optional(number)<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognitive_account"></a> [cognitive\_account](#output\_cognitive\_account) | n/a |
| <a name="output_cognitive_account_customer_managed_key"></a> [cognitive\_account\_customer\_managed\_key](#output\_cognitive\_account\_customer\_managed\_key) | n/a |
| <a name="output_cognitive_deployment"></a> [cognitive\_deployment](#output\_cognitive\_deployment) | n/a |

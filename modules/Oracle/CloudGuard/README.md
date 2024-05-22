## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.4 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.39.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_cloud_guard_cloud_guard_configuration.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_guard_cloud_guard_configuration) | resource |
| [oci_cloud_guard_data_mask_rule.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_guard_data_mask_rule) | resource |
| [oci_cloud_guard_data_source.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_guard_data_source) | resource |
| [oci_cloud_guard_detector_recipe.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_guard_detector_recipe) | resource |
| [oci_cloud_guard_managed_list.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_guard_managed_list) | resource |
| [oci_cloud_guard_responder_recipe.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_guard_responder_recipe) | resource |
| [oci_cloud_guard_security_recipe.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_guard_security_recipe) | resource |
| [oci_cloud_guard_security_zone.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_guard_security_zone) | resource |
| [oci_cloud_guard_target.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/cloud_guard_target) | resource |
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/data-sources/identity_compartment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_guard_configuration"></a> [cloud\_guard\_configuration](#input\_cloud\_guard\_configuration) | This resource provides the Cloud Guard Configuration resource in Oracle Cloud Infrastructure Cloud Guard service. | <pre>list(object({<br>    id                    = number<br>    reporting_region      = string<br>    status                = string<br>    self_manage_resources = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.<br>Gets the specified compartment's information. | `string` | n/a | yes |
| <a name="input_data_mask_rule"></a> [data\_mask\_rule](#input\_data\_mask\_rule) | This resource provides the Data Mask Rule resource in Oracle Cloud Infrastructure Cloud Guard service. | <pre>list(object({<br>    id                    = number<br>    data_mask_categories  = list(string)<br>    display_name          = string<br>    iam_group_id          = string<br>    data_mask_rule_status = optional(string)<br>    defined_tags          = optional(map(string))<br>    freeform_tags         = optional(map(string))<br>    description           = optional(string)<br>    state                 = optional(string)<br>    target_selected = list(object({<br>      kind   = string<br>      values = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_data_source"></a> [data\_source](#input\_data\_source) | This resource provides the Data Source resource in Oracle Cloud Infrastructure Cloud Guard service. | <pre>list(object({<br>    id                        = number<br>    data_source_feed_provider = string<br>    display_name              = string<br>    defined_tags              = optional(map(string))<br>    freeform_tags             = optional(map(string))<br>    data_source_details = optional(list(object({<br>      data_source_feed_provider = string<br>      additional_entities_count = optional(number)<br>      interval_in_minutes       = optional(number)<br>      logging_query_type        = optional(string)<br>      operator                  = optional(string)<br>      query                     = optional(string)<br>      regions                   = optional(list(string))<br>      threshold                 = optional(number)<br>      logging_query_details = optional(list(object({<br>        logging_query_type = string<br>        key_entities_count = optional(number)<br>      })), [])<br>      query_start_time = optional(list(object({<br>        start_policy_type = string<br>        query_start_time  = optional(string)<br>      })), [])<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_detector_recipe"></a> [detector\_recipe](#input\_detector\_recipe) | This resource provides the Detector Recipe resource in Oracle Cloud Infrastructure Cloud Guard service. | <pre>list(object({<br>    id                        = number<br>    display_name              = string<br>    defined_tags              = optional(map(string))<br>    freeform_tags             = optional(map(string))<br>    description               = optional(string)<br>    detector                  = optional(string)<br>    source_detector_recipe_id = optional(string)<br>    detector_rules = optional(list(object({<br>      detector_rule_id = string<br>      details = list(object({<br>        is_enabled     = bool<br>        risk_level     = string<br>        condition      = optional(string)<br>        data_source_id = optional(string)<br>        description    = optional(string)<br>        labels         = optional(list(string))<br>        recommendation = optional(string)<br>        configurations = optional(list(object({<br>          config_key = string<br>          name       = string<br>          data_type  = optional(string)<br>          value      = optional(string)<br>          values = optional(list(object({<br>            list_type         = string<br>            managed_list_type = string<br>            value             = string<br>          })), [])<br>        })), [])<br>        entities_mappings = optional(list(object({<br>          query_field  = string<br>          entity_type  = string<br>          display_name = optional(string)<br>        })), [])<br>      }))<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_managed_list"></a> [managed\_list](#input\_managed\_list) | This resource provides the Managed List resource in Oracle Cloud Infrastructure Cloud Guard service. | <pre>list(object({<br>    id                     = number<br>    display_name           = string<br>    defined_tags           = optional(map(string))<br>    freeform_tags          = optional(map(string))<br>    description            = optional(string)<br>    list_items             = optional(list(string))<br>    list_type              = optional(string)<br>    source_managed_list_id = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_responder_recipe"></a> [responder\_recipe](#input\_responder\_recipe) | This resource provides the Responder Recipe resource in Oracle Cloud Infrastructure Cloud Guard service. | <pre>list(object({<br>    id                         = number<br>    display_name               = string<br>    source_responder_recipe_id = number<br>    defined_tags               = optional(map(string))<br>    freeform_tags              = optional(map(string))<br>    description                = optional(string)<br>    responder_rules = optional(list(object({<br>      responder_rule_id = string<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_security_recipe"></a> [security\_recipe](#input\_security\_recipe) | This resource provides the Security Recipe resource in Oracle Cloud Infrastructure Cloud Guard service. | <pre>list(object({<br>    id                = number<br>    display_name      = string<br>    security_policies = list(string)<br>    defined_tags      = optional(map(string))<br>    freeform_tags     = optional(map(string))<br>    description       = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_security_zone"></a> [security\_zone](#input\_security\_zone) | This resource provides the Security Zone resource in Oracle Cloud Infrastructure Cloud Guard service. | <pre>list(object({<br>    id                      = number<br>    display_name            = string<br>    security_zone_recipe_id = string<br>    defined_tags            = optional(map(string))<br>    freeform_tags           = optional(map(string))<br>    description             = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_target"></a> [target](#input\_target) | This resource provides the Target resource in Oracle Cloud Infrastructure Cloud Guard service. | <pre>list(object({<br>    id                   = number<br>    display_name         = string<br>    target_resource_id   = string<br>    target_resource_type = string<br>    defined_tags         = optional(map(string))<br>    freeform_tags        = optional(map(string))<br>    description          = optional(string)<br>    state                = optional(string)<br>    target_detector_recipes = optional(list(object({<br>      detector_recipe_id = string<br>      detector_rules = optional(list(object({<br>        detector_rule_id = string<br>        details = optional(list(object({<br>          condition_groups = optional(list(object({<br>            compartment_id = string<br>            condition      = string<br>          })), [])<br>        })), [])<br>      })), [])<br>    })), [])<br>    target_responder_recipes = optional(list(object({<br>      responder_recipe_id = string<br>      responder_rules = optional(list(object({<br>        responder_rule_id = string<br>        details = optional(list(object({<br>          condition = string<br>          mode      = optional(string)<br>          configurations = optional(list(object({<br>            config_key = string<br>            name       = string<br>            value      = string<br>          })), [])<br>        })), [])<br>      })), [])<br>    })), [])<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud_guard_configuration"></a> [cloud\_guard\_configuration](#output\_cloud\_guard\_configuration) | n/a |
| <a name="output_data_mask_rule"></a> [data\_mask\_rule](#output\_data\_mask\_rule) | n/a |
| <a name="output_data_source"></a> [data\_source](#output\_data\_source) | n/a |
| <a name="output_managed_list"></a> [managed\_list](#output\_managed\_list) | n/a |
| <a name="output_recipe"></a> [recipe](#output\_recipe) | n/a |
| <a name="output_security_zone"></a> [security\_zone](#output\_security\_zone) | n/a |
| <a name="output_target"></a> [target](#output\_target) | n/a |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.4 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_adm_knowledge_base.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/adm_knowledge_base) | resource |
| [oci_adm_remediation_recipe.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/adm_remediation_recipe) | resource |
| [oci_adm_remediation_run.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/adm_remediation_run) | resource |
| [oci_adm_vulnerability_audit.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/adm_vulnerability_audit) | resource |
| [oci_core_subnet.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/core_subnet) | data source |
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/identity_compartment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | Compartment id - mandatory - to be used as data source | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | Defined tags | `map(string)` | `{}` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | Freeform tags | `map(string)` | `{}` | no |
| <a name="input_knowledge_base"></a> [knowledge\_base](#input\_knowledge\_base) | This resource provides the Knowledge Base resource in Oracle Cloud Infrastructure Adm service. | <pre>list(object({<br>    id            = number<br>    defined_tags  = optional(map(string))<br>    display_name  = optional(string)<br>    freeform_tags = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_remediation_recipe"></a> [remediation\_recipe](#input\_remediation\_recipe) | This resource provides the Remediation Recipe resource in Oracle Cloud Infrastructure Adm service. | <pre>list(object({<br>    id                            = number<br>    is_run_triggered_on_kb_change = bool<br>    knowledge_base_id             = number<br>    display_name                  = optional(string)<br>    defined_tags                  = optional(map(string))<br>    freeform_tags                 = optional(map(string))<br>    detect_configuration = list(object({<br>      exclusions                   = optional(list(string))<br>      max_permissible_cvss_v2score = optional(number)<br>      max_permissible_cvss_v3score = optional(number)<br>      upgrade_policy               = optional(string)<br>      max_permissible_severity     = optional(number)<br>    }))<br>    network_configuration = list(object({<br>      subnet_id = string<br>      nsg_ids   = optional(list(string))<br>    }))<br>    scm_configuration = list(object({<br>      branch                 = string<br>      is_automerge_enabled   = bool<br>      scm_type               = string<br>      build_file_location    = optional(string)<br>      oci_code_repository_id = optional(string)<br>      pat_secret_id          = optional(string)<br>      repository_url         = optional(string)<br>      username               = optional(string)<br>    }))<br>    verify_configuration = list(object({<br>      build_service_type    = string<br>      additional_parameters = optional(map(string))<br>      jenkins_url           = optional(string)<br>      job_name              = optional(string)<br>      pat_secret_id         = optional(string)<br>      pipeline_id           = optional(string)<br>      repository_url        = optional(string)<br>      trigger_secret_id     = optional(string)<br>      username              = optional(string)<br>      workflow_name         = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_remediation_run"></a> [remediation\_run](#input\_remediation\_run) | This resource provides the Remediation Run resource in Oracle Cloud Infrastructure Adm service. | <pre>list(object({<br>    id                    = number<br>    remediation_recipe_id = number<br>    defined_tags          = optional(map(string))<br>    freeform_tags         = optional(map(string))<br>    display_name          = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_vulnerability_audit"></a> [vulnerability\_audit](#input\_vulnerability\_audit) | This resource provides the Vulnerability Audit resource in Oracle Cloud Infrastructure Adm service.<br>Creates a new Vulnerability Audit by providing a tree of Application Dependencies. | <pre>list(object({<br>    id                = number<br>    build_type        = string<br>    knowledge_base_id = number<br>    display_name      = optional(string)<br>    defined_tags      = optional(map(string))<br>    freeform_tags     = optional(map(string))<br>    application_dependencies = optional(list(object({<br>      gav                             = string<br>      node_id                         = string<br>      application_dependency_node_ids = optional(list(string))<br>      purl                            = optional(string)<br>    })), [])<br>    configuration = optional(list(object({<br>      exclusions                   = optional(list(string))<br>      max_permissible_cvss_v2score = optional(number)<br>      max_permissible_cvss_v3score = optional(number)<br>      max_permissible_severity     = optional(number)<br>    })), [])<br>    source = optional(list(object({<br>      type            = string<br>      description     = optional(string)<br>      oci_resource_id = optional(string)<br>    })), [])<br>    usage_data = optional(list(object({<br>      bucket      = string<br>      namespace   = string<br>      object      = string<br>      source_type = string<br>    })), [])<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_knowledge_base"></a> [knowledge\_base](#output\_knowledge\_base) | n/a |
| <a name="output_remediation_recipe"></a> [remediation\_recipe](#output\_remediation\_recipe) | n/a |
| <a name="output_remediation_run"></a> [remediation\_run](#output\_remediation\_run) | n/a |
| <a name="output_vulnerability_audit"></a> [vulnerability\_audit](#output\_vulnerability\_audit) | n/a |

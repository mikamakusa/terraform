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
| [oci_service_mesh_access_policy.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/service_mesh_access_policy) | resource |
| [oci_service_mesh_ingress_gateway.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/service_mesh_ingress_gateway) | resource |
| [oci_service_mesh_ingress_gateway_route_table.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/service_mesh_ingress_gateway_route_table) | resource |
| [oci_service_mesh_mesh.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/service_mesh_mesh) | resource |
| [oci_service_mesh_virtual_deployment.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/service_mesh_virtual_deployment) | resource |
| [oci_service_mesh_virtual_service.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/service_mesh_virtual_service) | resource |
| [oci_service_mesh_virtual_service_route_table.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/service_mesh_virtual_service_route_table) | resource |
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/identity_compartment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policy"></a> [access\_policy](#input\_access\_policy) | This resource provides the Access Policy resource in Oracle Cloud Infrastructure Service Mesh service. | <pre>list(map(object({<br>    id            = number<br>    mesh_id       = number<br>    name          = string<br>    defined_tags  = optional(map(string))<br>    description   = optional(string)<br>    freeform_tags = optional(map(string))<br>    rules = list(object({<br>      action = string<br>      destination = list(object({<br>        type               = string<br>        hostnames          = optional(list(string))<br>        ingress_gateway_id = optional(string)<br>        ip_addresses       = optional(list(string))<br>        ports              = optional(list(string))<br>        protocol           = optional(string)<br>        virtual_service_id = optional(string)<br>      }))<br>      source = list(object({<br>        type               = string<br>        ingress_gateway_id = optional(string)<br>        ip_addresses       = optional(list(string))<br>        ports              = optional(list(string))<br>        protocol           = optional(string)<br>        virtual_service_id = optional(string)<br>      }))<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | Compartment id - mandatory - to be used as data source | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | Defined tags | `map(string)` | `{}` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | Freeform tags | `map(string)` | `{}` | no |
| <a name="input_ingress_gateway"></a> [ingress\_gateway](#input\_ingress\_gateway) | This resource provides the Ingress Gateway resource in Oracle Cloud Infrastructure Service Mesh service. | <pre>list(map(object({<br>    id            = number<br>    mesh_id       = number<br>    name          = string<br>    defined_tags  = optional(map(string))<br>    description   = optional(string)<br>    freeform_tags = optional(map(string))<br>    hosts = list(object({<br>      name      = string<br>      hostnames = optional(list(string))<br>      listeners = optional(list(object({<br>        port     = number<br>        protocol = optional(string)<br>        tls = optional(list(object({<br>          mode = string<br>          client_validation = optional(list(object({<br>            subject_alternate_names = optional(list(string))<br>            trusted_ca_bundle = optional(list(object({<br>              type         = string<br>              ca_bundle_id = optional(string)<br>              secret_name  = optional(string)<br>            })), [])<br>          })), [])<br>        })), [])<br>      })), [])<br>    }))<br>    access_logging = optional(list(object({<br>      is_enabled = optional(bool)<br>    })), [])<br>    mtls = optional(list(object({<br>      maximum_validity = optional(number)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_ingress_gateway_route_table"></a> [ingress\_gateway\_route\_table](#input\_ingress\_gateway\_route\_table) | This resource provides the Ingress Gateway Route Table resource in Oracle Cloud Infrastructure Service Mesh service. | <pre>list(map(object({<br>    id                 = number<br>    ingress_gateway_id = number<br>    name               = string<br>    defined_tags       = optional(map(string))<br>    description        = optional(string)<br>    freeform_tags      = optional(map(string))<br>    priority           = optional(number)<br>    route_rules = list(object({<br>      type                    = string<br>      is_grpc                 = optional(bool)<br>      is_host_rewrite_enabled = optional(bool)<br>      is_path_rewrite_enabled = optional(bool)<br>      path                    = optional(string)<br>      path_type               = optional(string)<br>      request_timeout_in_ms   = optional(string)<br>      destinations = list(object({<br>        virtual_service_id = string<br>        port               = optional(number)<br>        weight             = optional(number)<br>      }))<br>      ingress_gateway_host = optional(list(object({<br>        name = optional(string)<br>        port = optional(number)<br>      })), [])<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_mesh"></a> [mesh](#input\_mesh) | This resource provides the Mesh resource in Oracle Cloud Infrastructure Service Mesh service. | <pre>list(map(object({<br>    id            = number<br>    display_name  = string<br>    defined_tags  = optional(map(string))<br>    description   = optional(string)<br>    freeform_tags = optional(map(string))<br>    certificate_authorities = list(object({<br>      id = string<br>    }))<br>    mtls = optional(list(object({<br>      minimum = string<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_virtual_deployment"></a> [virtual\_deployment](#input\_virtual\_deployment) | This resource provides the Virtual Deployment resource in Oracle Cloud Infrastructure Service Mesh service. | <pre>list(map(object({<br>    id                 = number<br>    name               = string<br>    virtual_service_id = string<br>    defined_tags       = optional(map(string))<br>    description        = optional(string)<br>    freeform_tags      = optional(map(string))<br>    listeners = optional(list(object({<br>      port                  = number<br>      protocol              = string<br>      idle_timeout_in_ms    = optional(string)<br>      request_timeout_in_ms = optional(string)<br>    })), [])<br>    service_discovery = optional(list(object({<br>      type     = string<br>      hostname = optional(string)<br>    })), [])<br>    access_logging = optional(list(object({<br>      is_enabled = optional(bool)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_virtual_service"></a> [virtual\_service](#input\_virtual\_service) | This resource provides the Virtual Service resource in Oracle Cloud Infrastructure Service Mesh service. | <pre>list(map(object({<br>    id            = number<br>    mesh_id       = number<br>    name          = string<br>    defined_tags  = optional(map(string))<br>    description   = optional(string)<br>    freeform_tags = optional(map(string))<br>    hosts         = optional(string)<br>    default_routing_policy = optional(list(object({<br>      type = string<br>    })), [])<br>    mtls = optional(list(object({<br>      mode             = string<br>      maximum_validity = optional(number)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_virtual_service_route_table"></a> [virtual\_service\_route\_table](#input\_virtual\_service\_route\_table) | This resource provides the Virtual Service Route Table resource in Oracle Cloud Infrastructure Service Mesh service. | <pre>list(map(object({<br>    id                 = number<br>    name               = string<br>    virtual_service_id = number<br>    defined_tags       = optional(map(string))<br>    description        = optional(string)<br>    freeform_tags      = optional(map(string))<br>    priority           = optional(number)<br>    route_rules = list(object({<br>      type                    = string<br>      is_grpc                 = optional(bool)<br>      path                    = optional(string)<br>      path_type               = optional(string)<br>      request_timeout_in_ms   = optional(string)<br>      destinations = list(object({<br>        virtual_service_id = string<br>        port               = optional(number)<br>        weight             = optional(number)<br>      }))<br>    }))<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_policy_id"></a> [access\_policy\_id](#output\_access\_policy\_id) | n/a |
| <a name="output_access_policy_rules"></a> [access\_policy\_rules](#output\_access\_policy\_rules) | n/a |
| <a name="output_ingress_gateway_id"></a> [ingress\_gateway\_id](#output\_ingress\_gateway\_id) | n/a |
| <a name="output_ingress_gateway_route_table_id"></a> [ingress\_gateway\_route\_table\_id](#output\_ingress\_gateway\_route\_table\_id) | n/a |
| <a name="output_mesh_id"></a> [mesh\_id](#output\_mesh\_id) | n/a |
| <a name="output_virtual_deployment_id"></a> [virtual\_deployment\_id](#output\_virtual\_deployment\_id) | n/a |
| <a name="output_virtual_service_id"></a> [virtual\_service\_id](#output\_virtual\_service\_id) | n/a |
| <a name="output_virtual_service_route_table_id"></a> [virtual\_service\_route\_table\_id](#output\_virtual\_service\_route\_table\_id) | n/a |

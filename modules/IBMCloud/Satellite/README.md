## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.67.0-beta1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.67.0-beta1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_satellite_cluster.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_cluster) | resource |
| [ibm_satellite_cluster_worker_pool.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_cluster_worker_pool) | resource |
| [ibm_satellite_cluster_worker_pool_zone_attachment.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_cluster_worker_pool_zone_attachment) | resource |
| [ibm_satellite_endpoint.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_endpoint) | resource |
| [ibm_satellite_host.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_host) | resource |
| [ibm_satellite_link.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_link) | resource |
| [ibm_satellite_location.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_location) | resource |
| [ibm_satellite_location_nlb_dns.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_location_nlb_dns) | resource |
| [ibm_satellite_storage_assignment.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_storage_assignment) | resource |
| [ibm_satellite_storage_configuration.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/resources/satellite_storage_configuration) | resource |
| [ibm_cos_bucket.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/data-sources/cos_bucket) | data source |
| [ibm_resource_group.this](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.67.0-beta1/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>list(object({<br>    id                              = number<br>    location_id                     = number<br>    name                            = string<br>    crn_token                       = optional(string)<br>    default_worker_pool_labels      = optional(map(string))<br>    disable_public_service_endpoint = optional(bool)<br>    enable_config_admin             = optional(bool)<br>    host_labels                     = optional(list(string))<br>    infrastructure_topology         = optional(string)<br>    kube_version                    = optional(string)<br>    operating_system                = optional(string)<br>    patch_version                   = optional(string)<br>    pod_subnet                      = optional(string)<br>    pull_secret                     = optional(string)<br>    retry_patch_version             = optional(number)<br>    service_subnet                  = optional(string)<br>    tags                            = optional(list(string))<br>    wait_for_worker_update          = optional(bool)<br>    worker_count                    = optional(number)<br>    zones = optional(list(object({<br>      id = string<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_worker_pool"></a> [cluster\_worker\_pool](#input\_cluster\_worker\_pool) | n/a | <pre>list(object({<br>    id                 = number<br>    cluster_id         = number<br>    name               = string<br>    disk_encryption    = optional(bool)<br>    entitlement        = optional(string)<br>    flavor             = optional(string)<br>    host_labels        = optional(list(string))<br>    isolation          = optional(string)<br>    operating_system   = optional(string)<br>    resource_group_id  = optional(string)<br>    worker_count       = optional(number)<br>    worker_pool_labels = optional(map(string))<br>    zones = optional(list(object({<br>      id = string<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_cluster_worker_pool_zone_attachment"></a> [cluster\_worker\_pool\_zone\_attachment](#input\_cluster\_worker\_pool\_zone\_attachment) | n/a | <pre>list(object({<br>    id             = number<br>    cluster_id     = number<br>    worker_pool_id = number<br>    zone           = string<br>  }))</pre> | `[]` | no |
| <a name="input_cos_bucket"></a> [cos\_bucket](#input\_cos\_bucket) | n/a | `string` | `null` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | n/a | <pre>list(object({<br>    id                 = number<br>    client_protocol    = string<br>    connection_type    = string<br>    display_name       = string<br>    location_id        = number<br>    server_host        = string<br>    server_port        = number<br>    client_mutual_auth = optional(bool)<br>    created_by         = optional(string)<br>    server_mutual_auth = optional(bool)<br>    server_protocol    = optional(string)<br>    sni                = optional(string)<br>    timeout            = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_host"></a> [host](#input\_host) | n/a | <pre>list(object({<br>    id             = number<br>    host_id        = string<br>    location_id    = number<br>    host_provider  = optional(string)<br>    labels         = optional(list(string))<br>    worker_pool_id = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_link"></a> [link](#input\_link) | n/a | <pre>list(object({<br>    id          = number<br>    location_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | <pre>list(object({<br>    id                 = number<br>    location           = string<br>    managed_from       = string<br>    resource_group_id  = optional(number)<br>    zones              = optional(list(string))<br>    coreos_enabled     = optional(bool)<br>    description        = optional(string)<br>    logging_account_id = optional(string)<br>    pod_subnet         = optional(string)<br>    service_subnet     = optional(string)<br>    cos_config = optional(list(object({<br>      endpoint = optional(string)<br>      region   = optional(string)<br>    })), [])<br>    cos_credentials = optional(list(object({<br>      access_key_id     = optional(string)<br>      secret_access_key = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_location_nlb_dns"></a> [location\_nlb\_dns](#input\_location\_nlb\_dns) | n/a | <pre>list(object({<br>    id          = number<br>    ips         = list(string)<br>    location_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_storage_assignment"></a> [storage\_assignment](#input\_storage\_assignment) | n/a | <pre>list(object({<br>    id                     = number<br>    assignment_name        = string<br>    config_id              = number<br>    cluster_id             = optional(number)<br>    groups                 = optional(list(string))<br>    update_config_revision = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_storage_configuration"></a> [storage\_configuration](#input\_storage\_configuration) | n/a | <pre>list(object({<br>    id                       = number<br>    config_name              = string<br>    location_id              = number<br>    storage_template_name    = string<br>    storage_template_version = string<br>    user_config_parameters   = map(string)<br>    user_secret_parameters   = map(string)<br>    delete_assignments       = optional(bool)<br>    storage_class_parameters = optional(list(map(string)))<br>    update_assignments       = optional(bool)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster"></a> [cluster](#output\_cluster) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_worker_pool"></a> [worker\_pool](#output\_worker\_pool) | n/a |

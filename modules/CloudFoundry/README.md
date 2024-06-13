## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.6.4 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement\_cloudfoundry) | 0.53.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | 0.53.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudfoundry_app.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/app) | resource |
| [cloudfoundry_asg.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/asg) | resource |
| [cloudfoundry_buildpack.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/buildpack) | resource |
| [cloudfoundry_default_asg.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/default_asg) | resource |
| [cloudfoundry_domain.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/domain) | resource |
| [cloudfoundry_evg.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/evg) | resource |
| [cloudfoundry_feature_flags.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/feature_flags) | resource |
| [cloudfoundry_isolation_segment.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/isolation_segment) | resource |
| [cloudfoundry_isolation_segment_entitlement.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/isolation_segment_entitlement) | resource |
| [cloudfoundry_network_policy.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/network_policy) | resource |
| [cloudfoundry_org.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/org) | resource |
| [cloudfoundry_org_quota.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/org_quota) | resource |
| [cloudfoundry_org_users.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/org_users) | resource |
| [cloudfoundry_private_domain_access.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/private_domain_access) | resource |
| [cloudfoundry_route.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/route) | resource |
| [cloudfoundry_route_destination.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/route_destination) | resource |
| [cloudfoundry_route_service_binding.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/route_service_binding) | resource |
| [cloudfoundry_service_binding.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/service_binding) | resource |
| [cloudfoundry_service_broker.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/service_broker) | resource |
| [cloudfoundry_service_instance.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/service_instance) | resource |
| [cloudfoundry_service_key.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/service_key) | resource |
| [cloudfoundry_service_plan_access.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/service_plan_access) | resource |
| [cloudfoundry_space.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/space) | resource |
| [cloudfoundry_space_quota.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/space_quota) | resource |
| [cloudfoundry_space_users.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/space_users) | resource |
| [cloudfoundry_user.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/user) | resource |
| [cloudfoundry_user_provided_service.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/resources/user_provided_service) | resource |
| [cloudfoundry_domain.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/data-sources/domain) | data source |
| [cloudfoundry_service.this](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/0.51.3/docs/data-sources/service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | n/a | <pre>list(object({<br>    id                              = number<br>    name                            = string<br>    space                           = string<br>    annotations                     = optional(map(string))<br>    source_code_hash                = optional(string)<br>    stack                           = optional(string)<br>    stopped                         = optional(bool)<br>    strategy                        = optional(string)<br>    buildpacks                      = optional(list(string))<br>    buildpack_id                    = optional(any)<br>    disk_quota                      = optional(number)<br>    docker_credentials              = optional(map(string))<br>    docker_image                    = optional(string)<br>    instances                       = optional(number)<br>    enable_ssh                      = optional(bool)<br>    health_check_http_endpoint      = optional(string)<br>    health_check_invocation_timeout = optional(number)<br>    health_check_timeout            = optional(number)<br>    health_check_type               = optional(string)<br>    environment                     = optional(map(string))<br>    labels                          = optional(map(string))<br>    path                            = optional(string)<br>    ports                           = optional(list(string))<br>    memory                          = optional(number)<br>    timeout                         = optional(number)<br>    command                         = optional(string)<br>    routes = optional(list(object({<br>      route = string<br>      port  = optional(number)<br>    })), [])<br>    service_binding = optional(list(object({<br>      service_instance = string<br>      params           = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_asg"></a> [asg](#input\_asg) | n/a | <pre>list(object({<br>    id          = number<br>    destination = string<br>    protocol    = string<br>    ports       = optional(string)<br>    type        = optional(number)<br>    code        = optional(number)<br>    log         = optional(bool)<br>    description = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_buildpack"></a> [buildpack](#input\_buildpack) | n/a | <pre>list(object({<br>    id               = number<br>    name             = string<br>    path             = string<br>    position         = optional(number)<br>    enabled          = optional(bool)<br>    locked           = optional(bool)<br>    labels           = optional(map(string))<br>    annotations      = optional(map(string))<br>    source_code_hash = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_cloudfoundry_domain_name"></a> [cloudfoundry\_domain\_name](#input\_cloudfoundry\_domain\_name) | n/a | `string` | `null` | no |
| <a name="input_cloudfoundry_service"></a> [cloudfoundry\_service](#input\_cloudfoundry\_service) | n/a | `string` | `null` | no |
| <a name="input_default_asg"></a> [default\_asg](#input\_default\_asg) | n/a | <pre>list(object({<br>    id   = number<br>    asgs = any<br>    name = string<br>  }))</pre> | `[]` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | <pre>list(object({<br>    id           = number<br>    name         = string<br>    domain_id    = optional(any)<br>    sub_domain   = optional(string)<br>    router_group = optional(any)<br>    org_id       = optional(any)<br>    internal     = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_evg"></a> [evg](#input\_evg) | n/a | <pre>list(object({<br>    id        = number<br>    name      = string<br>    variables = map(string)<br>  }))</pre> | `[]` | no |
| <a name="input_feature_flags"></a> [feature\_flags](#input\_feature\_flags) | n/a | <pre>list(object({<br>    id = number<br>    feature_flags = optional(list(object({<br>      user_org_creation                    = optional(string)<br>      private_domain_creation              = optional(string)<br>      app_bits_upload                      = optional(string)<br>      app_scaling                          = optional(string)<br>      route_creation                       = optional(string)<br>      service_instance_creation            = optional(string)<br>      diego_docker                         = optional(string)<br>      set_roles_by_username                = optional(string)<br>      unset_roles_by_username              = optional(string)<br>      task_creation                        = optional(string)<br>      env_var_visibility                   = optional(string)<br>      space_scoped_private_broker_creation = optional(string)<br>      space_developer_env_var_visibility   = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_isolation_segment"></a> [isolation\_segment](#input\_isolation\_segment) | n/a | <pre>list(object({<br>    id          = number<br>    name        = string<br>    labels      = optional(map(string))<br>    annotations = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_isolation_segment_entitlement"></a> [isolation\_segment\_entitlement](#input\_isolation\_segment\_entitlement) | n/a | <pre>list(object({<br>    id         = number<br>    orgs_id    = list(any)<br>    segment_id = any<br>    default    = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | n/a | <pre>list(object({<br>    id = number<br>    policy = optional(list(object({<br>      destination_app = string<br>      port            = string<br>      source_app      = string<br>      protocol        = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_org"></a> [org](#input\_org) | n/a | <pre>list(object({<br>    id          = number<br>    name        = string<br>    quota       = optional(string)<br>    labels      = optional(map(string))<br>    annotations = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_org_quota"></a> [org\_quota](#input\_org\_quota) | n/a | <pre>list(object({<br>    id                       = number<br>    allow_paid_service_plans = bool<br>    name                     = string<br>    total_memory             = number<br>    total_routes             = number<br>    total_services           = number<br>    instance_memory          = optional(number)<br>    total_app_instances      = optional(number)<br>    total_route_ports        = optional(number)<br>    total_private_domains    = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_org_users"></a> [org\_users](#input\_org\_users) | n/a | <pre>list(object({<br>    id               = number<br>    org              = string<br>    managers         = optional(list(string))<br>    billing_managers = optional(list(string))<br>    auditors         = optional(list(string))<br>    force            = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | n/a | <pre>list(object({<br>    id                = number<br>    name              = string<br>    org               = any<br>    quota             = optional(string)<br>    allow_ssh         = optional(bool)<br>    isolation_segment = optional(any)<br>    asgs              = optional(list(any))<br>    staging_asgs      = optional(list(any))<br>    labels            = optional(map(string))<br>    annotations       = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_private_domain_access"></a> [private\_domain\_access](#input\_private\_domain\_access) | n/a | <pre>list(object({<br>    id     = number<br>    domain = string<br>    org    = string<br>  }))</pre> | `[]` | no |
| <a name="input_route"></a> [route](#input\_route) | n/a | <pre>list(object({<br>    id       = number<br>    domain   = string<br>    space    = string<br>    hostname = optional(string)<br>    port     = optional(number)<br>    path     = optional(string)<br>    target = optional(list(object({<br>      app  = string<br>      port = optional(number)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_route_destination"></a> [route\_destination](#input\_route\_destination) | n/a | <pre>list(object({<br>    id       = number<br>    app_id   = any<br>    route_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_route_service_binding"></a> [route\_service\_binding](#input\_route\_service\_binding) | n/a | <pre>list(object({<br>    id               = number<br>    route            = string<br>    service_instance = string<br>    json_params      = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_service_binding"></a> [service\_binding](#input\_service\_binding) | n/a | <pre>list(object({<br>    id                  = number<br>    app_id              = any<br>    service_instance_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_service_broker"></a> [service\_broker](#input\_service\_broker) | n/a | <pre>list(object({<br>    id                               = number<br>    name                             = string<br>    password                         = string<br>    url                              = string<br>    username                         = string<br>    space                            = optional(any)<br>    fail_when_catalog_not_accessible = optional(bool)<br>    labels                           = optional(map(string))<br>    annotations                      = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_service_instance"></a> [service\_instance](#input\_service\_instance) | n/a | <pre>list(object({<br>    id                             = number<br>    name                           = string<br>    service_plan                   = any<br>    space                          = any<br>    json_params                    = optional(string)<br>    tags                           = optional(list(string))<br>    recursive_delete               = optional(bool)<br>    replace_on_params_change       = optional(bool)<br>    replace_on_service_plan_change = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_service_key"></a> [service\_key](#input\_service\_key) | n/a | <pre>list(object({<br>    id               = number<br>    name             = string<br>    service_instance = any<br>    params           = optional(map(string))<br>    params_json      = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_service_plan_access"></a> [service\_plan\_access](#input\_service\_plan\_access) | n/a | <pre>list(object({<br>    id     = number<br>    plan   = any<br>    org    = optional(any)<br>    public = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_space"></a> [space](#input\_space) | n/a | <pre>list(object({<br>    id                = number<br>    name              = string<br>    org               = string<br>    quota             = optional(string)<br>    allow_ssh         = optional(bool)<br>    isolation_segment = optional(string)<br>    asgs              = optional(list(string))<br>    staging_asgs      = optional(list(string))<br>    labels            = optional(map(string))<br>    annotations       = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_space_quota"></a> [space\_quota](#input\_space\_quota) | n/a | <pre>list(object({<br>    id                       = number<br>    allow_paid_service_plans = bool<br>    name                     = string<br>    org                      = any<br>    total_memory             = number<br>    total_routes             = number<br>    total_services           = number<br>    instance_memory          = optional(number)<br>    total_app_instances      = optional(number)<br>    total_route_ports        = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_space_users"></a> [space\_users](#input\_space\_users) | n/a | <pre>list(object({<br>    id         = number<br>    space      = any<br>    managers   = optional(list(string))<br>    auditors   = optional(list(string))<br>    developers = optional(list(string))<br>    force      = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_user"></a> [user](#input\_user) | n/a | <pre>list(object({<br>    id          = number<br>    name        = string<br>    password    = optional(string)<br>    origin      = optional(string)<br>    given_name  = optional(string)<br>    family_name = optional(string)<br>    email       = optional(string)<br>    groups      = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_user_provided_service"></a> [user\_provided\_service](#input\_user\_provided\_service) | n/a | <pre>list(object({<br>    id                = number<br>    name              = string<br>    space             = any<br>    credentials       = optional(list(string))<br>    credentials_json  = optional(string)<br>    syslog_drain_url  = optional(string)<br>    route_service_url = optional(string)<br>    tags              = optional(list(string))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app"></a> [app](#output\_app) | n/a |
| <a name="output_domain"></a> [domain](#output\_domain) | n/a |
| <a name="output_org"></a> [org](#output\_org) | n/a |
| <a name="output_route"></a> [route](#output\_route) | n/a |
| <a name="output_space"></a> [space](#output\_space) | n/a |
| <a name="output_users"></a> [users](#output\_users) | n/a |

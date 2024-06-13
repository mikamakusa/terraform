variable "cloudfoundry_domain_name" {
  type    = string
  default = null
}

variable "cloudfoundry_service" {
  type    = string
  default = null
}

variable "app" {
  type = list(object({
    id                              = number
    name                            = string
    space_id                        = string
    annotations                     = optional(map(string))
    source_code_hash                = optional(string)
    stack                           = optional(string)
    stopped                         = optional(bool)
    strategy                        = optional(string)
    buildpacks                      = optional(list(string))
    buildpack_id                    = optional(any)
    disk_quota                      = optional(number)
    docker_credentials              = optional(map(string))
    docker_image                    = optional(string)
    instances                       = optional(number)
    enable_ssh                      = optional(bool)
    health_check_http_endpoint      = optional(string)
    health_check_invocation_timeout = optional(number)
    health_check_timeout            = optional(number)
    health_check_type               = optional(string)
    environment                     = optional(map(string))
    labels                          = optional(map(string))
    path                            = optional(string)
    ports                           = optional(list(string))
    memory                          = optional(number)
    timeout                         = optional(number)
    command                         = optional(string)
    routes = optional(list(object({
      route = string
      port  = optional(number)
    })), [])
    service_binding = optional(list(object({
      service_instance = string
      params           = optional(string)
    })), [])
  }))
  default = []
}

variable "asg" {
  type = list(object({
    id          = number
    destination = string
    protocol    = string
    ports       = optional(string)
    type        = optional(number)
    code        = optional(number)
    log         = optional(bool)
    description = optional(string)
  }))
  default = []
}

variable "buildpack" {
  type = list(object({
    id               = number
    name             = string
    path             = string
    position         = optional(number)
    enabled          = optional(bool)
    locked           = optional(bool)
    labels           = optional(map(string))
    annotations      = optional(map(string))
    source_code_hash = optional(string)
  }))
  default = []
}

variable "default_asg" {
  type = list(object({
    id   = number
    asgs = any
    name = string
  }))
  default = []
}

variable "domain" {
  type = list(object({
    id           = number
    name         = string
    domain_id    = optional(any)
    sub_domain   = optional(string)
    router_group = optional(any)
    org_id       = optional(any)
    internal     = optional(bool)
  }))
  default = []
}

variable "evg" {
  type = list(object({
    id        = number
    name      = string
    variables = map(string)
  }))
  default = []
}

variable "feature_flags" {
  type = list(object({
    id = number
    feature_flags = optional(list(object({
      user_org_creation                    = optional(string)
      private_domain_creation              = optional(string)
      app_bits_upload                      = optional(string)
      app_scaling                          = optional(string)
      route_creation                       = optional(string)
      service_instance_creation            = optional(string)
      diego_docker                         = optional(string)
      set_roles_by_username                = optional(string)
      unset_roles_by_username              = optional(string)
      task_creation                        = optional(string)
      env_var_visibility                   = optional(string)
      space_scoped_private_broker_creation = optional(string)
      space_developer_env_var_visibility   = optional(string)
    })), [])
  }))
  default = []
}

variable "isolation_segment" {
  type = list(object({
    id          = number
    name        = string
    labels      = optional(map(string))
    annotations = optional(map(string))
  }))
  default = []
}

variable "isolation_segment_entitlement" {
  type = list(object({
    id         = number
    orgs_id    = list(any)
    segment_id = any
    default    = optional(bool)
  }))
  default = []
}

variable "network_policy" {
  type = list(object({
    id = number
    policy = optional(list(object({
      destination_app = string
      port            = string
      source_app      = string
      protocol        = optional(string)
    })), [])
  }))
  default = []
}

variable "org" {
  type = list(object({
    id          = number
    name        = string
    quota       = optional(string)
    labels      = optional(map(string))
    annotations = optional(map(string))
  }))
  default = []
}

variable "org_quota" {
  type = list(object({
    id                       = number
    allow_paid_service_plans = bool
    name                     = string
    total_memory             = number
    total_routes             = number
    total_services           = number
    instance_memory          = optional(number)
    total_app_instances      = optional(number)
    total_route_ports        = optional(number)
    total_private_domains    = optional(number)
  }))
  default = []
}

variable "org_users" {
  type = list(object({
    id               = number
    org              = string
    managers         = optional(list(string))
    billing_managers = optional(list(string))
    auditors         = optional(list(string))
    force            = optional(bool)
  }))
  default = []
}

variable "private_domain_access" {
  type = list(object({
    id     = number
    domain = string
    org    = string
  }))
  default = []
}

variable "route" {
  type = list(object({
    id       = number
    domain   = string
    space    = string
    hostname = optional(string)
    port     = optional(number)
    path     = optional(string)
    target = optional(list(object({
      app  = string
      port = optional(number)
    })), [])
  }))
  default = []
}

variable "route_destination" {
  type = list(object({
    id       = number
    app_id   = any
    route_id = any
  }))
  default = []
}

variable "route_service_binding" {
  type = list(object({
    id               = number
    route            = string
    service_instance = string
    json_params      = optional(string)
  }))
  default = []
}

variable "service_binding" {
  type = list(object({
    id                  = number
    app_id              = any
    service_instance_id = any
  }))
  default = []
}

variable "service_broker" {
  type = list(object({
    id                               = number
    name                             = string
    password                         = string
    url                              = string
    username                         = string
    space                            = optional(any)
    fail_when_catalog_not_accessible = optional(bool)
    labels                           = optional(map(string))
    annotations                      = optional(map(string))
  }))
  default = []
}

variable "service_instance" {
  type = list(object({
    id                             = number
    name                           = string
    service_plan                   = any
    space                          = any
    json_params                    = optional(string)
    tags                           = optional(list(string))
    replace_on_params_change       = optional(bool)
    replace_on_service_plan_change = optional(bool)
  }))
  default = []
}

variable "service_key" {
  type = list(object({
    id               = number
    name             = string
    service_instance = any
    params           = optional(map(string))
    params_json      = optional(string)
  }))
  default = []
}

variable "service_plan_access" {
  type = list(object({
    id     = number
    plan   = any
    org    = optional(any)
    public = optional(bool)
  }))
  default = []
}

variable "plan" {
  type = list(object({
    id                = number
    name              = string
    org               = any
    quota             = optional(string)
    allow_ssh         = optional(bool)
    isolation_segment = optional(any)
    asgs              = optional(list(any))
    staging_asgs      = optional(list(any))
    labels            = optional(map(string))
    annotations       = optional(map(string))
  }))
  default = []
}

variable "space" {
  type = list(object({
    id                = number
    name              = string
    org               = string
    quota             = optional(string)
    allow_ssh         = optional(bool)
    isolation_segment = optional(string)
    asgs              = optional(list(string))
    staging_asgs      = optional(list(string))
    labels            = optional(map(string))
    annotations       = optional(map(string))
  }))
  default = []
}

variable "space_quota" {
  type = list(object({
    id                       = number
    allow_paid_service_plans = bool
    name                     = string
    org                      = any
    total_memory             = number
    total_routes             = number
    total_services           = number
    instance_memory          = optional(number)
    total_app_instances      = optional(number)
    total_route_ports        = optional(number)
  }))
  default = []
}

variable "space_users" {
  type = list(object({
    id         = number
    space      = any
    managers   = optional(list(string))
    auditors   = optional(list(string))
    developers = optional(list(string))
    force      = optional(bool)
  }))
  default = []
}

variable "user" {
  type = list(object({
    id          = number
    name        = string
    password    = optional(string)
    origin      = optional(string)
    given_name  = optional(string)
    family_name = optional(string)
    email       = optional(string)
    groups      = optional(list(string))
  }))
  default = []
}

variable "user_provided_service" {
  type = list(object({
    id                = number
    name              = string
    space             = any
    credentials       = optional(list(string))
    credentials_json  = optional(string)
    syslog_drain_url  = optional(string)
    route_service_url = optional(string)
    tags              = optional(list(string))
  }))
  default = []
}
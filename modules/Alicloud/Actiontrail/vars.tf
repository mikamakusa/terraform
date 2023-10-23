variable "buckets" {
  type        = string
  default     = null
  description = <<-EOT
    Name of the bucket used as datasource
  EOT
}

variable "roles" {
  type        = string
  default     = null
  description = <<-EOT
    Name of the role used as datasource
EOT
}

variable "topics" {
  type    = string
  default = null
}

variable "log_project" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "mns_topics" {
  type = list(map(object({
    name                 = string
    maximum_message_size = optional(number, 0)
    logging_enabled      = optional(bool, true)
  })))
  default = {}
}

variable "ram_roles" {
  type = list(map(object({
    id                   = number
    name                 = string
    services             = optional(set(string))
    ram_users            = optional(set(string))
    version              = optional(string)
    document             = optional(string)
    description          = optional(string)
    force                = optional(bool, false)
    max_session_duration = optional(number, 3600)
  })))
  default     = []
  description = <<-EOT
    name                 = string / Name of the RAM role. This name can have a string of 1 to 64 characters, must contain only alphanumeric characters or hyphens, such as "-", "_", and must not begin with a hyphen.
    services             = optional(set(string)) / List of services which can assume the RAM role.
    ram_users            = optional(set(string)) / List of ram users who can assume the RAM role.
    version              = optional(string) / Version of the RAM role policy document.
    document             = optional(string) / Authorization strategy of the RAM role.
    description          = optional(string) / Description of the RAM role.
    force                = optional(bool, false) / This parameter is used for resource destroy.
    max_session_duration = optional(number, 3600) / The maximum session duration of the RAM role. Valid values: 3600 to 43200.
EOT
}

variable "ram_policy" {
  type = list(map(object({
    id          = number
    policy_name = string
    statement = optional(list(object({
      resource = list(string)
      action   = list(string)
      effect   = string
    })), [])
    version         = optional(string)
    description     = optional(string)
    rotate_strategy = optional(string)
    force           = optional(bool, false)
  })))
  default     = []
  description = <<-EOT
    policy_name = string / Name of the RAM policy. This name can have a string of 1 to 128 characters, must contain only alphanumeric characters or hyphen "-", and must not begin with a hyphen.
    statement = optional(list(object) / Statements of the RAM policy document.
      resource = list(string) / List of specific objects which will be authorized.
      action   = list(string) / List of operations for the resource.
      effect   = string / This parameter indicates whether or not the action is allowed. Valid values are Allow and Deny.
    version         = optional(string) / Version of the RAM policy document. Valid value is 1. Default value is 1.
    description     = optional(string) / Description of the RAM policy.
    rotate_strategy = optional(string) / The rotation strategy of the policy.
    force           = optional(bool, false) / This parameter is used for resource destroy.
EOT
}

variable "role_policy_attachement" {
  type = list(map(object({
    id        = number
    policy_id = number
    role_id   = number
  })))
  default = []
}

variable "oss_bucket" {
  type = list(map(object({
    id     = number
    bucket = string
    tags   = map(string)
  })))
  default = []
}

variable "actiontrail" {
  type = list(map(object({
    id                 = number
    name               = string
    event_rw           = optional(string)
    oss_bucket_id      = optional(number)
    role_id            = optional(number)
    oss_key_prefix     = optional(string)
    sls_project_arn    = optional(string)
    sls_write_role_arn = optional(string)
  })))
  default     = []
  description = <<-EOT
EOT
}

variable "storage_region" {
  type    = string
  default = null
}

variable "delivery_job" {
  type = list(map(object({
    id       = number
    trail_id = number
  })))
  default = []
}

variable "trail" {
  type = list(map(object({
    id                    = number
    trail_id              = optional(number)
    name                  = optional(string)
    event_rw              = optional(string)
    oss_bucket_id         = optional(number)
    oss_key_prefix        = optional(string)
    role_name             = optional(number)
    sls_project_id        = optional(number)
    sls_write_role_arn    = optional(string)
    mns_topic_id          = optional(number)
    status                = optional(string)
    is_organization_trail = optional(bool, false)
  })))
  default = []
}

variable "log_projects" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
    tags        = optional(map(string))
  })))
  default = []
}
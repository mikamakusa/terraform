variable "tags" {
  type    = map(string)
  default = {}
}

variable "application" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
    tags        = optional(map(string))
  })))
  default     = []
  description = <<EOF
Provides an AppConfig Application resource.
EOF
}

variable "configuration_profile" {
  type = list(map(object({
    id                 = number
    application_id     = number
    location_uri       = string
    name               = string
    description        = optional(string)
    retrieval_role_arn = optional(string)
    tags               = optional(map(string))
    type               = optional(string)
    validator = optional(list(object({
      type    = string
      content = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
Provides an AppConfig Configuration Profile resource.
EOF
}

variable "deployment" {
  type = list(map(object({
    id                       = number
    application_id           = number
    configuration_profile_id = number
    configuration_version    = string
    deployment_strategy_id   = number
    environment_id           = number
    description              = optional(string)
    tags                     = optional(map(string))
  })))
  default     = []
  description = <<EOF
Provides an AppConfig Deployment resource for an aws_appconfig_application resource.
EOF
}

variable "deployment_strategy" {
  type = list(map(object({
    id                             = number
    deployment_duration_in_minutes = number
    growth_factor                  = number
    name                           = string
    replicate_to                   = string
    description                    = optional(string)
    final_bake_time_in_minutes     = optional(number)
    growth_type                    = optional(string)
    tags                           = optional(map(string))
  })))
  default     = []
  description = <<EOF
Provides an AppConfig Deployment Strategy resource.
EOF
}

variable "environment" {
  type = list(map(object({
    id             = number
    application_id = number
    name           = string
    description    = optional(string)
    tags           = optional(map(string))
    monitor = optional(list(object({
      alarm_arn      = string
      alarm_role_arn = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
Provides an AppConfig Environment resource for an aws_appconfig_application resource. One or more environments can be defined for an application.
EOF
}

variable "extension" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
    tags        = optional(map(string))
    action_point = list(object({
      point = string
      action = list(object({
        name     = string
        role_arn = string
        uri      = string
      }))
    }))
    parameter = optional(list(object({
      name        = string
      required    = optional(bool)
      description = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
Provides an AppConfig Extension resource.
EOF
}

variable "extension_association" {
  type = list(map(object({
    id           = number
    extension_id = number
    resource_id  = number
    parameters   = optional(map(string))
  })))
  default     = []
  description = <<EOF
Associates an AppConfig Extension with a Resource.
EOF
}

variable "hosted_configuration_version" {
  type = list(map(object({
    id                       = number
    application_id           = number
    configuration_profile_id = number
    content                  = string
    content_type             = string
    description              = optional(string)
  })))
  default     = []
  description = <<EOF
Provides an AppConfig Hosted Configuration Version resource.
EOF
}

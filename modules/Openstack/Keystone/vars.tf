variable "project_name" {
  type = string
}

variable "project_v3" {
  type = list(object({
    id          = number
    name        = optional(string)
    description = optional(string)
    domain_id   = optional(string)
    enabled     = optional(bool)
    is_domain   = optional(bool)
    parent_id   = optional(string)
    region      = optional(string)
    tags        = optional(list(string))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "application_credential_v3" {
  type = list(object({
    id           = number
    name         = string
    region       = optional(string)
    description  = optional(string)
    unrestricted = optional(bool)
    secret       = optional(string)
    roles        = optional(list(string))
    expires_at   = optional(string)
    access_rules = optional(list(object({
      method  = string
      path    = string
      service = string
    })))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "ec2_credential_v3" {
  type = list(object({
    id         = number
    project_id = optional(number)
    user_id    = optional(number)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "endpoint_v3" {
  type = list(object({
    id         = number
    service_id = number
    url        = string
    name       = optional(string)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "group_v3" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    domain_id   = optional(string)
    region      = optional(number)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "inherit_role_assignment_v3" {
  type = list(object({
    id         = number
    role_id    = number
    domain_id  = optional(string)
    group_id   = optional(number)
    project_id = optional(number)
    user_id    = optional(number)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "role_assignment_v3" {
  type = list(object({
    id         = number
    role_id    = number
    domain_id  = optional(string)
    group_id   = optional(number)
    project_id = optional(number)
    user_id    = optional(number)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "role_v3" {
  type = list(object({
    id         = number
    name       = string
    domain_id  = optional(string)
    project_id = optional(number)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "service_v3" {
  type = list(object({
    id          = number
    name        = string
    type        = string
    project_id  = optional(number)
    description = optional(string)
    enabled     = optional(bool)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "user_membership_v3" {
  type = list(object({
    id         = number
    group_id   = number
    user_id    = number
    project_id = optional(number)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "user_v3" {
  type = list(object({
    id                                    = number
    description                           = optional(string)
    default_project_id                    = optional(string)
    domain_id                             = optional(string)
    enabled                               = optional(bool)
    extra                                 = optional(map(string))
    ignore_change_password_upon_first_use = optional(bool)
    ignore_lockout_failure_attempts       = optional(bool)
    ignore_password_expiry                = optional(bool)
    multi_factor_auth_enabled             = optional(bool)
    name                                  = optional(string)
    password                              = optional(string)
    multi_factor_auth_rule = optional(list(object({
      rule = list(string)
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "host_pool_name" {
  type    = string
  default = null
}

variable "service_principal" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "resource_group_name" {
  type    = string
  default = null
}

variable "role_assignment_name" {
  type    = string
  default = null
}

variable "role_assignment" {
  type = list(map(object({
    id = number
    resource_group_id = number

  })))
  default = []
}

variable "resource_group" {
  type = list(map(object({
    id       = number
    location = string
    name     = string
    tags     = optional(map(string))
  })))
  default = []
}

variable "host_pool" {
  type = list(map(object({
    id                               = number
    load_balancer_type               = string
    name                             = string
    resource_group_id                = string
    type                             = string
    friendly_name                    = optional(string)
    description                      = optional(string)
    validate_environment             = optional(bool, false)
    start_vm_on_connect              = optional(bool, false)
    custom_rdp_properties            = optional(string)
    personal_desktop_assignment_type = optional(string)
    maximum_sessions_allowed         = optional(number)
    preferred_app_group_type         = optional(string)
    tags                             = optional(map(string))
    scheduled_agent_updates = optional(list(object({
      enabled                   = optional(bool, false)
      timezone                  = optional(string)
      use_session_host_timezone = optional(bool, false)
      schedule = optional(list(object({
        day_of_week = string
        hour_of_day = number
      })), [])
    })), [])
  })))
  default = []
}

variable "scaling_plan" {
  type = list(map(object({
    id                = number
    name              = string
    resource_group_id = number
    time_zone         = string
    description       = optional(string)
    exclusion_tag     = optional(string)
    friendly_name     = optional(string)
    tags              = optional(map(string))
    host_pool = optional(list(object({
      hostpool_id          = number
      scaling_plan_enabled = bool
    })), [])
    schedule = optional(list(object({
      days_of_week                         = list(string)
      name                                 = string
      off_peak_load_balancing_algorithm    = string
      off_peak_start_time                  = string
      peak_load_balancing_algorithm        = string
      peak_start_time                      = string
      ramp_down_capacity_threshold_percent = number
      ramp_down_force_logoff_users         = bool
      ramp_down_load_balancing_algorithm   = string
      ramp_down_minimum_hosts_percent      = number
      ramp_down_notification_message       = string
      ramp_down_start_time                 = string
      ramp_down_stop_hosts_when            = string
      ramp_down_wait_time_minutes          = number
      ramp_up_load_balancing_algorithm     = string
      ramp_up_start_time                   = string
      ramp_up_capacity_threshold_percent   = optional(number)
      ramp_up_minimum_hosts_percent        = optional(number)
    })), [])
  })))
  default = []
}

variable "registration_info" {
  type = list(map(object({
    id           = number
    host_pool_id = number
  })))
  default = []
}

variable "application_group" {
  type = list(map(object({
    id                           = number
    host_pool_id                 = number
    name                         = string
    resource_group_id            = number
    type                         = string
    friendly_name                = optional(string)
    default_desktop_display_name = optional(string)
    description                  = optional(string)
    tags                         = optional(map(string))
  })))
  default = []
}

variable "desktop_application" {
  type = list(map(object({
    id                           = number
    application_group_id         = string
    command_line_argument_policy = string
    name                         = string
    path                         = string
    friendly_name                = optional(string)
    description                  = optional(string)
    command_line_arguments       = optional(string)
    show_in_portal               = optional(bool, false)
    icon_path                    = optional(string)
    icon_index                   = optional(number)
  })))
  default = []
}

variable "desktop_workspace" {
  type = list(map(object({
    id                            = number
    name                          = string
    resource_group_id             = number
    friendly_name                 = optional(string)
    description                   = optional(string)
    public_network_access_enabled = optional(bool, false)
    tags                          = optional(map(string))
  })))
  default = []
}

variable "group_association" {
  type = list(map(object({
    id                   = number
    application_group_id = number
    workspace_id         = number
  })))
  default = []
}
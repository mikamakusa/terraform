variable "region" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "directory_service_id" {
  type = string
}

variable "directory" {
  type = list(map(object({
    id         = string
    subnet_ids = optional(list(string))
    tags       = optional(map(string))
    self_service_permissions = optional(list(object({
      change_compute_type  = optional(bool)
      increase_volume_size = optional(bool)
      rebuild_workspace    = optional(bool)
      restart_workspace    = optional(bool)
      switch_running_mode  = optional(bool)
    })), [])
    workspace_access_properties = optional(list(object({
      device_type_android    = optional(string)
      device_type_chromeos   = optional(string)
      device_type_ios        = optional(string)
      device_type_osx        = optional(string)
      device_type_web        = optional(string)
      device_type_windows    = optional(string)
      device_type_zeroclient = optional(string)
    })), [])
    workspace_creation_properties = optional(list(object({
      custom_security_group_id            = optional(string)
      default_ou                          = optional(string)
      enable_internet_access              = optional(bool)
      enable_maintenance_mode             = optional(bool)
      user_enabled_as_local_administrator = optional(bool)
    })), [])
  })))
  default = []
}

variable "ip_group" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
    tags        = optional(map(string))
    rules = optional(list(object({
      source      = string
      description = optional(string)
    })), [])
  })))
  default = []
}

variable "workspace" {
  type = list(map(object({
    id                             = number
    bundle_id                      = string
    directory_id                   = number
    user_name                      = string
    root_volume_encryption_enabled = optional(bool)
    user_volume_encryption_enabled = optional(bool)
    volume_encryption_key          = optional(string)
    tags                           = optional(map(string))
    workspace_properties = optional(list(object({
      compute_type_name                         = optional(string)
      root_volume_size_gib                      = optional(number)
      running_mode                              = optional(string)
      running_mode_auto_stop_timeout_in_minutes = optional(number)
      user_volume_size_gib                      = optional(string)
    })), [])
  })))
  default = []
}
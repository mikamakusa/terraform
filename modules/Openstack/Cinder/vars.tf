variable "project_name" {
  type = string
}

variable "qos_association_v3" {
  type = list(object({
    id             = number
    qos_id         = number
    volume_type_id = number
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "qos_v3" {
  type = list(object({
    id       = number
    name     = string
    consumer = optional(string)
    specs    = optional(map(string))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "quotaset_v3" {
  type = list(object({
    id                   = number
    volumes              = optional(number)
    snapshots            = optional(number)
    gigabytes            = optional(number)
    per_volume_gigabytes = optional(number)
    backups              = optional(number)
    backup_gigabytes     = optional(number)
    groups               = optional(number)
    volume_type_quota    = optional(map(string))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "volume_attach_v3" {
  type = list(object({
    id          = number
    host_name   = string
    volume_id   = number
    attach_mode = optional(string)
    device      = optional(string)
    initiator   = optional(string)
    ip_address  = optional(string)
    multipath   = optional(bool)
    os_type     = optional(string)
    platform    = optional(string)
    wwnn        = optional(string)
    wwpn        = optional(list(string))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "volume_type_access_v3" {
  type = list(object({
    id             = number
    volume_type_id = number
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "volume_type_v3" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    is_public   = optional(bool)
    extra_specs = optional(map(string))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "volume_v3" {
  type = list(object({
    id                   = number
    size                 = number
    enable_online_resize = optional(bool)
    availability_zone    = optional(string)
    consistency_group_id = optional(string)
    description          = optional(string)
    metadata             = optional(map(string))
    name                 = optional(string)
    source_replica       = optional(string)
    snapshot_id          = optional(string)
    source_vol_id        = optional(string)
    image_id             = optional(string)
    backup_id            = optional(string)
    volume_type          = optional(string)
    multiattach          = optional(bool)
    scheduler_hints = optional(list(object({
      different_host        = optional(list(string))
      same_host             = optional(list(string))
      local_to_instance     = optional(string)
      query                 = optional(string)
      additional_properties = optional(map(string))
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

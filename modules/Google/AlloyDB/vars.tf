variable "labels" {
  type    = map(string)
  default = []
}

variable "backup" {
  type = list(map(object({
    id           = number
    backup_id    = string
    cluster_id   = number
    location     = string
    display_name = optional(string)
    labels       = optional(map(string))
    type         = optional(string)
    description  = optional(string)
    annotations  = optional(map(string))
    project      = optional(string)
    encryption_config = optional(list(object({
      kms_key_name = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
An AlloyDB Backup.
EOF
}

variable "cluster" {
  type = list(map(object({
    id               = number
    cluster_id       = string
    location         = string
    labels           = optional(map(string))
    display_name     = optional(string)
    etag             = optional(string)
    annotations      = optional(map(string))
    database_version = optional(string)
    cluster_type     = optional(string)
    project          = optional(string)
    deletion_policy  = optional(string)
    encryption_config = optional(list(object({
      kms_key_name = optional(string)
    })), [])
    network_config = optional(list(object({
      network            = optional(string)
      allocated_ip_range = optional(string)
    })), [])
    initial_user = optional(list(object({
      password = string
      user     = optional(string)
    })), [])
    restore_backup_source = optional(list(object({
      backup_name = string
    })), [])
    restore_continuous_backup_source = optional(list(object({
      cluster       = string
      point_in_time = string
    })), [])
    continuous_backup_config = optional(list(object({
      enabled              = optional(bool)
      recovery_window_days = optional(number)
      encryption_config = optional(list(object({
        kms_key_name = optional(string)
      })), [])
    })), [])
    automated_backup_policy = optional(list(object({
      backup_window = optional(string)
      location      = optional(string)
      labels        = optional(map(string))
      enabled       = optional(bool)
      encryption_config = optional(list(object({
        kms_key_name = optional(string)
      })), [])
      weekly_schedule = optional(list(object({
        days_of_week = optional(list(string))
        start_times = optional(list(object({
          hours   = optional(number)
          minutes = optional(number)
          seconds = optional(number)
          nanos   = optional(number)
        })), [])
      })), [])
      time_based_retention = optional(list(object({
        retention_period = optional(string)
      })), [])
      quantity_based_retention = optional(list(object({
        count = optional(number)
      })), [])
    })), [])
    secondary_config = optional(list(object({
      primary_cluster_name = string
    })), [])
  })))
  default = []
  description = <<EOF
A managed alloydb cluster cluster.
EOF
}

variable "instance" {
  type = list(map(object({
    id                = number
    cluster_id        = number
    instance_id       = string
    instance_type     = string
    labels            = optional(map(string))
    annotations       = optional(map(string))
    display_name      = optional(string)
    gce_zone          = optional(string)
    database_flags    = optional(map(string))
    availability_type = optional(string)
    query_insights_config = optional(list(object({
      query_string_length     = optional(number)
      record_application_tags = optional(number)
      record_client_address   = optional(number)
      query_plans_per_minute  = optional(number)
    })), [])
    read_pool_config = optional(list(object({
      node_count = optional(number)
    })), [])
    machine_config = optional(list(object({
      cpu_count = optional(number)
    })), [])
    client_connection_config = optional(list(object({
      require_connectors = optional(bool)
      ssl_config = optional(list(object({
        ssl_mode = optional(string)
      })), [])
    })), [])
  })))
  default = []
  description = <<EOF
A managed alloydb cluster instance.
EOF
}

variable "user" {
  type = list(map(object({
    id             = number
    cluster_id     = number
    user_id        = string
    user_type      = string
    password       = optional(string)
    database_roles = optional(list(string))
  })))
  default = []
  description = <<EOF
A database user in an AlloyDB cluster.
EOF
}
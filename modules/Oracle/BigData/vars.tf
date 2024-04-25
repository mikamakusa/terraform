variable "defined_tags" {
  type    = map(string)
  default = {}
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
}

variable "auto_scaling_configuration" {
  type = list(map(object({
    id                     = number
    bds_instance_id        = number
    cluster_admin_password = string
    is_enabled             = bool
    node_type              = string
    display_name           = optional(string)
    policy = optional(list(object({
      policy_type = optional(string)
      rules = optional(list(object({
        action = optional(string)
        metric = optional(list(object({
          metric_type = optional(string)
          threshold = optional(list(object({
            duration_in_minutes = number
            operator            = string
            value               = number
          })), [])
        })), [])
      })), [])
    })), [])
    policy_details = optional(list(object({
      policy_type = string
      timezone    = optional(string)
      scale_down_config = optional(list(object({
        memory_step_size    = optional(number)
        ocpu_step_size      = optional(number)
        min_memory_per_node = optional(number)
        min_ocpus_per_node  = optional(number)
        metric = optional(list(object({
          metric_type = optional(string)
          threshold = optional(list(object({
            duration_in_minutes = optional(number)
            operator            = optional(string)
            value               = optional(number)
          })), [])
        })), [])
      })), [])
      scale_in_config = optional(list(object({
        max_memory_per_node = optional(number)
        max_ocpus_per_node  = optional(number)
        memory_step_size    = optional(number)
        metric = optional(list(object({
          metric_type = optional(string)
          threshold = optional(list(object({
            duration_in_minutes = optional(number)
            operator            = optional(string)
            value               = optional(number)
          })), [])
        })), [])
      })), [])
      scale_out_config = optional(list(object({
        max_node_count = optional(number)
        step_size      = optional(number)
        metric = optional(list(object({
          metric_type = optional(string)
          threshold = optional(list(object({
            duration_in_minutes = optional(number)
            operator            = optional(string)
            value               = optional(number)
          })), [])
        })), [])
      })), [])
      scale_up_config = optional(list(object({
        max_memory_per_node = optional(number)
        max_ocpus_per_node  = optional(number)
        memory_step_size    = optional(number)
        ocpu_step_size      = optional(number)
        metric = optional(list(object({
          metric_type = optional(string)
          threshold = optional(list(object({
            duration_in_minutes = optional(number)
            operator            = optional(string)
            value               = optional(number)
          })), [])
        })), [])
      })), [])
      schedule_details = optional(list(object({
        schedule_type = optional(string)
        time_and_horizontal_scaling_config = optional(list(object({
          target_node_count = optional(number)
          time_recurrence   = optional(string)
        })), [])
        time_and_vertical_scaling_config = optional(list(object({
          target_memory_per_node = optional(number)
          target_ocpus_per_node  = optional(number)
          target_shape           = optional(string)
          time_recurrence        = optional(string)
        })), [])
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "bds_instance" {
  type = list(map(object({
    id                     = number
    cluster_admin_password = string
    cluster_public_key     = string
    cluster_version        = string
    compartment_id         = string
    display_name           = string
    is_high_availability   = bool
    is_secure              = bool
    is_force_stop_jobs     = optional(bool)
    is_kafka_configured    = optional(bool)
    defined_tags           = optional(map(string))
    freeform_tags          = optional(map(string))
    kerberos_realm_name    = optional(string)
    kms_key_id             = optional(string)
    state                  = optional(string)
    os_patch_version       = optional(string)
    cloud_sql_details = optional(list(object({
      shape = string
    })), [])
    network_config = optional(list(object({
      cidr_block              = string
      is_nat_gateway_required = optional(bool)
    })), [])
    master_node = optional(list(object({
      number_of_nodes          = number
      shape                    = string
      subnet_id                = string
      block_volume_size_in_gbs = optional(string)
      shape_config = optional(list(object({
        memory_in_gbs = optional(number)
        nvmes         = optional(number)
        ocpus         = optional(number)
      })), [])
    })), [])
    util_node = optional(list(object({
      number_of_nodes          = number
      shape                    = string
      subnet_id                = string
      block_volume_size_in_gbs = optional(string)
      shape_config = optional(list(object({
        memory_in_gbs = optional(number)
        nvmes         = optional(number)
        ocpus         = optional(number)
      })), [])
    })), [])
    worker_node = optional(list(object({
      number_of_nodes          = number
      shape                    = string
      subnet_id                = string
      block_volume_size_in_gbs = optional(string)
      shape_config = optional(list(object({
        memory_in_gbs = optional(number)
        nvmes         = optional(number)
        ocpus         = optional(number)
      })), [])
    })), [])
    compute_only_worker_node = optional(list(object({
      number_of_nodes          = number
      shape                    = string
      subnet_id                = string
      block_volume_size_in_gbs = optional(string)
      shape_config = optional(list(object({
        memory_in_gbs = optional(number)
        nvmes         = optional(number)
        ocpus         = optional(number)
      })), [])
    })), [])
    kafka_broker_node = optional(list(object({
      number_of_nodes          = number
      shape                    = string
      subnet_id                = string
      block_volume_size_in_gbs = optional(string)
      shape_config = optional(list(object({
        memory_in_gbs = optional(number)
        nvmes         = optional(number)
        ocpus         = optional(number)
      })), [])
    })), [])
    edge_node = optional(list(object({
      number_of_nodes          = number
      shape                    = string
      subnet_id                = string
      block_volume_size_in_gbs = optional(string)
      shape_config = optional(list(object({
        memory_in_gbs = optional(number)
        nvmes         = optional(number)
        ocpus         = optional(number)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "bds_instance_api_key" {
  type = list(map(object({
    id              = number
    bds_instance_id = number
    key_alias       = string
    passphrase      = string
    user_id         = string
    default_region  = optional(string)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "bds_instance_metastore_config" {
  type = list(map(object({
    id                     = number
    bds_api_key_id         = string
    bds_api_key_passphrase = string
    bds_instance_id        = number
    cluster_admin_password = string
    metastore_id           = string
    display_name           = optional(string)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "bds_instance_patch_action" {
  type = list(map(object({
    id                     = number
    bds_instance_id        = number
    cluster_admin_password = string
    version                = string
  })))
  default     = []
  description = <<EOF
  EOF
}
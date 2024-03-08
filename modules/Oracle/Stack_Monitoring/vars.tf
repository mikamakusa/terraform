variable "defined_tags" {
  type        = map(string)
  default     = {}
  description = "Defined tags"
}

variable "freeform_tags" {
  type        = map(string)
  default     = {}
  description = "Freeform tags"
}

variable "compartment_id" {
  type        = string
  description = "Compartment id - mandatory - to be used as data source"
}

variable "baselineable_metric" {
  type = list(map(object({
    id             = number
    column         = string
    name           = string
    namespace      = string
    resource_group = string
  })))
  default = []
  description = <<EOF
This resource provides the Baselineable Metric resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "config" {
  type = list(map(object({
    id            = number
    config_type   = string
    defined_tags  = optional(map(string))
    display_name  = optional(string)
    freeform_tags = optional(map(string))
    is_enabled    = optional(bool)
    license       = optional(string)
    resource_type = optional(string)
  })))
  default     = []
  description = <<EOF
This resource provides the Config resource in Oracle Cloud Infrastructure Stack Monitoring service.
Creates a configuration item, for example to define whether resources of a specific type should be discovered automatically.
For example, when a new Management Agent gets registered in a certain compartment, this Management Agent can potentially get promoted to a HOST resource. The configuration item will determine if HOST resources in the selected compartment will be discovered automatically.
EOF
}

variable "discovery_job" {
  type = list(map(object({
    id                                            = number
    defined_tags                                  = optional(map(string))
    discovery_client                              = optional(string)
    discovery_type                                = optional(string)
    freeform_tags                                 = optional(map(string))
    should_propagate_tags_to_discovered_resources = optional(bool)
    discovery_details = optional(list(object({
      agent_id      = string
      resource_name = string
      resource_type = string
      credentials = optional(list(object({
        items = optional(list(object({
          credential_name = string
          credential_type = string
          properties = optional(list(object({
            properties_map = optional(map(string))
          })), [])
        })), [])
        properties = optional(list(object({
          properties_map = optional(map(string))
        })), [])
        tags = optional(list(object({
          properties_map = optional(map(string))
        })), [])
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Discovery Job resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "metric_extension" {
  type = list(map(object({
    id                     = number
    collection_recurrences = string
    display_name           = string
    name                   = string
    resource_type          = string
    publish_trigger        = optional(bool)
    metric_list = list(object({
      data_type       = string
      name            = string
      is_dimension    = optional(bool)
      is_hidden       = optional(bool)
      metric_category = optional(string)
      unit            = optional(string)
    }))
    query_properties = list(object({
      collection_method         = string
      arguments                 = optional(string)
      auto_row_prefix           = optional(string)
      command                   = optional(string)
      delimiter                 = optional(string)
      identity_metric           = optional(string)
      is_metric_service_enabled = optional(bool)
      jmx_attributes            = optional(string)
      managed_bean_query        = optional(string)
      sql_type                  = optional(string)
      starts_with               = optional(string)
      in_param_details = optional(list(object({
        in_param_position = number
        in_param_value    = string
      })), [])
      out_param_details = optional(list(object({
        out_param_position = number
        out_param_type     = string
      })), [])
      script_details = optional(list(object({
        content = string
        name    = string
      })), [])
      sql_details = optional(list(object({
        content          = string
        script_file_name = optional(string)
      })), [])
    }))
  })))
  default     = []
  description = <<EOF
This resource provides the Metric Extension resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "metric_extension_metric_extension_on_given_resources_management" {
  type = list(map(object({
    id           = number
    resource_ids = string
  })))
  default     = []
  description = <<EOF
This resource provides the Metric Extension Metric Extension On Given Resources Management resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "metric_extensions_test_management" {
  type = list(map(object({
    id           = number
    resource_ids = string
  })))
  default     = []
  description = <<EOF
This resource provides the Metric Extensions Test Management resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "monitored_resource" {
  type = list(map(object({
    id                   = number
    name                 = string
    type                 = string
    defined_tags         = optional(map(string))
    display_name         = optional(string)
    external_id          = optional(string)
    external_resource_id = optional(string)
    freeform_tags        = optional(map(string))
    host_name            = optional(string)
    license              = optional(string)
    management_agent_id  = optional(string)
    resource_time_zone   = optional(string)
    additional_aliases = optional(list(object({
      name   = string
      source = string
      credential = optional(list(object({
        name    = string
        service = string
        source  = string
      })), [])
    })), [])
    additional_credentials = optional(list(object({
      credential_type = optional(string)
      description     = optional(string)
      source          = optional(string)
      key_id          = optional(string)
      name            = optional(string)
      type            = optional(string)
      properties = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })), [])
    })), [])
    aliases = optional(list(object({
      name   = string
      source = string
      credential = optional(list(object({
        name    = string
        service = string
        source  = string
      })), [])
    })), [])
    credentials = optional(list(object({
      credential_type = optional(string)
      description     = optional(string)
      key_id          = optional(string)
      name            = optional(string)
      source          = optional(string)
      type            = optional(string)
      properties = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })), [])
    })), [])
    database_connection_details = optional(list(object({
      port           = number
      protocol       = string
      service_name   = string
      connector_id   = string
      db_id          = optional(string)
      db_unique_name = optional(string)
      ssl_secret_id  = optional(string)
    })), [])
    properties = optional(list(object({
      name  = optional(string)
      value = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Monitored Resource resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "monitored_resource_task" {
  type = list(map(object({
    id            = number
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    name          = optional(string)
    task_details = list(object({
      namespace                                     = string
      source                                        = string
      type                                          = string
      availability_proxy_metric_collection_interval = optional(number)
      availability_proxy_metrics                    = optional(list(string))
      resource_group                                = optional(number)
    }))
  })))
  default     = []
  description = <<EOF
This resource provides the Monitored Resource Task resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "monitored_resource_type" {
  type = list(map(object({
    id               = number
    name             = string
    defined_tags     = optional(map(string))
    description      = optional(string)
    display_name     = optional(string)
    freeform_tags    = optional(map(string))
    metric_namespace = optional(string)
    metadata = optional(list(object({
      format                      = string
      agent_properties            = optional(list(string))
      required_properties         = optional(string)
      valid_properties_for_create = optional(list(string))
      valid_properties_for_update = optional(list(string))
      valid_property_values       = optional(map(string))
      unique_property_sets = optional(list(object({
        properties = list(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Monitored Resource Type resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "monitored_resources_associate_monitored_resource" {
  type = list(map(object({
    id                      = number
    association_type        = string
    destination_resource_id = string
    source_resource_id      = string
  })))
  default     = []
  description = <<EOF
This resource provides the Monitored Resources Associate Monitored Resource resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "monitored_resources_list_member" {
  type = list(map(object({
    id                      = number
    monitored_resource_id   = string
    destination_resource_id = optional(string)
    limit_level             = optional(number)
  })))
  default     = []
  description = <<EOF
This resource provides the Monitored Resources List Member resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "monitored_resources_search" {
  type = list(map(object({
    id                                    = number
    exclude_fields                        = optional(list(string))
    external_id                           = optional(string)
    fields                                = optional(list(string))
    host_name                             = optional(string)
    host_name_contains                    = optional(string)
    license                               = optional(string)
    management_agent_id                   = optional(string)
    name                                  = optional(string)
    name_contains                         = optional(string)
    property_equals                       = optional(map(string))
    resource_time_zone                    = optional(string)
    state                                 = optional(string)
    time_created_greater_than_or_equal_to = optional(string)
    time_created_less_than                = optional(string)
    time_updated_greater_than_or_equal_to = optional(string)
    time_updated_less_than                = optional(string)
    type                                  = optional(string)
  })))
  default     = []
  description = <<EOF
This resource provides the Monitored Resources Search resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "monitored_resources_search_association" {
  type = list(map(object({
    id                        = number
    association_type          = optional(string)
    destination_resource_id   = optional(string)
    destination_resource_name = optional(string)
    destination_resource_type = optional(string)
    source_resource_id        = optional(string)
    source_resource_name      = optional(string)
    source_resource_type      = optional(string)
  })))
  default     = []
  description = <<EOF
This resource provides the Monitored Resources Search Association resource in Oracle Cloud Infrastructure Stack Monitoring service.
EOF
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type    = string
  default = null
}

variable "storage_container_name" {
  type    = string
  default = null
}

variable "cosmosdb_account_name" {
  type    = string
  default = null
}

variable "cosmosdb_sql_database_name" {
  type    = string
  default = null
}

variable "storage_table_name" {
  type    = string
  default = null
}

variable "eventhub_consumer_group_name" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "cluster" {
  type = list(object({
    id                 = number
    name               = string
    streaming_capacity = number
    tags               = optional(map(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "function_javascript_uda" {
  type = list(object({
    id                      = number
    name                    = string
    script                  = string
    stream_analytics_job_id = number
    input = optional(list(object({
      type                    = string
      configuration_parameter = optional(bool)
    })), [])
    output = optional(list(object({
      type = string
    })), [])
  }))
  default     = []
  description = <<EOF
EOF
}

variable "function_javascript_udf" {
  type = list(object({
    id                      = number
    name                    = string
    script                  = string
    stream_analytics_job_id = number
    input = optional(list(object({
      type                    = string
      configuration_parameter = optional(bool)
    })), [])
    output = optional(list(object({
      type = string
    })), [])
  }))
  default = []
}

variable "job" {
  type = list(object({
    id                                       = number
    name                                     = string
    transformation_query                     = string
    compatibility_level                      = optional(string)
    content_storage_policy                   = optional(string)
    data_locale                              = optional(string)
    events_late_arrival_max_delay_in_seconds = optional(number)
    events_out_of_order_max_delay_in_seconds = optional(number)
    events_out_of_order_policy               = optional(string)
    output_error_policy                      = optional(string)
    stream_analytics_cluster_id              = optional(number)
    streaming_units                          = optional(number)
    tags                                     = optional(map(string))
    type                                     = optional(string)
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
    job_storage_account = optional(list(object({
      account_key         = string
      account_name        = string
      authentication_mode = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
EOF
}

variable "job_schedule" {
  type = list(object({
    id                      = number
    start_mode              = string
    stream_analytics_job_id = number
    start_time              = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "managed_private_endpoint" {
  type = list(object({
    id                          = number
    name                        = string
    stream_analytics_cluster_id = number
    subresource_name            = string
    target_resource_id          = number
  }))
  default     = []
  description = <<EOF
EOF
}

variable "output_blob" {
  type = list(object({
    id                      = number
    date_format             = string
    name                    = string
    path_pattern            = string
    stream_analytics_job_id = number
    time_format             = string
    authentication_mode     = optional(string)
    batch_max_wait_time     = optional(string)
    batch_min_rows          = optional(number)
    storage_account_key     = optional(string)
    serialization = list(object({
      type            = string
      encoding        = optional(string)
      field_delimiter = optional(string)
      format          = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "cosmosdb_sql_container" {
  type = list(object({
    id                 = number
    name               = string
    partition_key_path = string
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "output_cosmosdb" {
  type = list(object({
    id                      = number
    container_id            = number
    name                    = string
    stream_analytics_job_id = number
    document_id             = string
    partition_key           = string
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "eventhub_namespace_name" {
  type    = string
  default = null
}

variable "eventhub_name" {
  type    = string
  default = null
}

variable "output_eventhub" {
  type = list(object({
    id                        = number
    name                      = string
    stream_analytics_job_id   = number
    shared_access_policy_key  = optional(string)
    shared_access_policy_name = optional(string)
    property_columns          = optional(list(string))
    authentication_mode       = optional(string)
    partition_key             = optional(string)
    serialization = list(object({
      type            = string
      encoding        = optional(string)
      field_delimiter = optional(string)
      format          = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "function_app_name" {
  type    = string
  default = null
}

variable "output_function" {
  type = list(object({
    id                      = number
    api_key                 = string
    function_name           = string
    name                    = string
    stream_analytics_job_id = number
    batch_max_count         = optional(number)
    batch_max_in_bytes      = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "sql_server_name" {
  type    = string
  default = null
}
variable "sql_database_name" {
  type    = string
  default = null
}

variable "output_mssql" {
  type = list(object({
    id                      = number
    name                    = string
    stream_analytics_job_id = number
    table                   = string
    authentication_mode     = optional(string)
    max_batch_count         = optional(number)
    max_writer_count        = optional(number)
    password                = optional(string)
    user                    = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "servicebus_namespace_name" {
  type    = string
  default = null
}

variable "servicebus_queue_name" {
  type    = string
  default = null
}

variable "servicebus_topic_name" {
  type    = string
  default = null
}

variable "output_powerbi" {
  type = list(object({
    id                        = number
    dataset                   = string
    group_id                  = string
    group_name                = string
    name                      = string
    stream_analytics_job_id   = number
    table                     = string
    token_user_display_name   = optional(string)
    token_user_principal_name = optional(string)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "output_servicebus_queue" {
  type = list(object({
    id                        = number
    name                      = string
    queue_name                = string
    stream_analytics_job_id   = number
    authentication_mode       = optional(string)
    property_columns          = optional(list(string))
    shared_access_policy_name = optional(string)
    system_property_columns   = optional(map(string))
    serialization = list(object({
      type            = string
      encoding        = optional(string)
      field_delimiter = optional(string)
      format          = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "output_servicebus_topic" {
  type = list(object({
    id                        = number
    name                      = string
    stream_analytics_job_id   = number
    authentication_mode       = optional(string)
    property_columns          = optional(list(string))
    shared_access_policy_name = optional(string)
    system_property_columns   = optional(map(string))
    serialization = list(object({
      type            = string
      encoding        = optional(string)
      field_delimiter = optional(string)
      format          = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "synapse_workspace" {
  type = list(object({
    id                               = number
    name                             = string
    sql_administrator_login          = optional(string)
    sql_administrator_login_password = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "output_synapse" {
  type = list(object({
    id                      = number
    database                = string
    name                    = string
    synapse_workspace_id    = number
    stream_analytics_job_id = number
    table                   = string
  }))
  default     = []
  description = <<EOF
EOF
}

variable "output_table" {
  type = list(object({
    id                      = number
    batch_size              = number
    name                    = string
    partition_key           = string
    row_key                 = string
    stream_analytics_job_id = number
    columns_to_remove       = optional(list(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "reference_input_blob" {
  type = list(object({
    id                      = number
    date_format             = string
    name                    = string
    path_pattern            = string
    stream_analytics_job_id = number
    time_format             = string
    authentication_mode     = optional(string)
    serialization = list(object({
      type            = string
      encoding        = optional(string)
      field_delimiter = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "reference_input_mssql" {
  type = list(object({
    id                        = number
    full_snapshot_query       = string
    name                      = string
    password                  = string
    refresh_type              = string
    stream_analytics_job_id   = number
    username                  = string
    refresh_interval_duration = optional(string)
    delta_snapshot_query      = optional(string)
    table                     = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "stream_input_blob" {
  type = list(object({
    id           = number
    date_format  = string
    name         = string
    path_pattern = string
    time_format  = string
    serialization = list(object({
      type            = string
      encoding        = optional(string)
      field_delimiter = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "stream_input_eventhub" {
  type = list(object({
    id                        = number
    name                      = string
    stream_analytics_job_id   = number
    authentication_mode       = optional(string)
    partition_key             = optional(string)
    shared_access_policy_key  = optional(string)
    shared_access_policy_name = optional(string)
    serialization = list(object({
      type            = string
      encoding        = optional(string)
      field_delimiter = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "iothub" {
  type = list(object({
    id                            = number
    name                          = string
    local_authentication_enabled  = optional(bool)
    event_hub_partition_count     = optional(number)
    event_hub_retention_in_days   = optional(number)
    endpoint                      = optional(list(string))
    public_network_access_enabled = optional(bool)
    min_tls_version               = optional(string)
    tags                          = optional(map(string))
    sku = list(object({
      name     = string
      capacity = string
    }))
    cloud_to_device = optional(list(object({
      default_ttl        = optional(string)
      max_delivery_count = optional(number)
      feedback = optional(list(object({
        time_to_live       = optional(string)
        max_delivery_count = optional(number)
        lock_duration      = optional(string)
      })), optional(list(string)))
    })), optional(list(string)))
    endpoint = optional(list(object({
      authentication_type        = optional(string)
      batch_frequency_in_seconds = optional(number)
      connection_string          = optional(string)
      container_name             = optional(string)
      encoding                   = optional(string)
      endpoint_uri               = optional(string)
      entity_path                = optional(string)
      file_name_format           = optional(string)
      identity_id                = optional(string)
      max_chunk_size_in_bytes    = optional(number)
      name                       = optional(string)
      resource_group_name        = optional(string)
      type                       = optional(string)
    })), optional(list(string)))
    enrichment = optional(list(object({
      key            = optional(string)
      value          = optional(string)
      endpoint_names = optional(list(string))
    })), optional(list(string)))
    fallback_route = optional(list(object({
      source         = optional(string)
      condition      = optional(string)
      enabled        = optional(bool)
      endpoint_names = optional(list(string))
    })), optional(list(string)))
    file_upload = optional(list(object({
      connection_string   = string
      container_name      = string
      authentication_type = optional(string)
      default_ttl         = optional(string)
      lock_duration       = optional(string)
      max_delivery_count  = optional(number)
      notifications       = optional(bool)
      sas_ttl             = optional(string)
    })), optional(list(string)))
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), optional(list(string)))
    network_rule_set = optional(list(object({
      default_action                     = optional(string)
      apply_to_builtin_eventhub_endpoint = optional(bool)
      ip_rule = optional(list(object({
        ip_mask = optional(string)
        name    = optional(string)
        action  = optional(string)
      })), optional(list(string)))
    })), optional(list(string)))
    route = optional(list(object({
      name           = optional(string)
      source         = optional(string)
      condition      = optional(string)
      endpoint_names = optional(list(string))
      enabled        = optional(bool)
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "stream_input_iothub" {
  type = list(object({
    id                           = number
    iothub_id                    = number
    name                         = string
    stream_analytics_job_id      = number
    endpoint                     = string
    eventhub_consumer_group_name = string
    shared_access_policy_name    = string
    serialization = list(object({
      type            = string
      encoding        = optional(string)
      field_delimiter = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
  EOF
}
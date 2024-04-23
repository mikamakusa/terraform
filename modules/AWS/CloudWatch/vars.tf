variable "tags" {
  type    = map(string)
  default = {}
}

variable "resource_group_name" {
  type = string
}

variable "composite_alarm" {
  type = list(map(object({
    id                        = number
    alarm_name                = string
    alarm_rule                = string
    actions_enabled           = optional(bool)
    alarm_actions             = optional(set(string))
    alarm_description         = optional(string)
    insufficient_data_actions = optional(set(string))
    ok_actions                = optional(set(string))
    tags                      = optional(map(string))
  })))
  default     = []
  description = <<EOF
EOF
}

variable "dashboard" {
  type = list(map(object({
    id             = number
    dashboard_body = string
    dashboard_name = string
  })))
  default     = []
  description = <<EOF
EOF
}

variable "metric_alarm" {
  type = list(map(object({
    id                                    = number
    alarm_id                              = number
    comparison_operator                   = string
    evaluation_periods                    = number
    metric_name                           = optional(string)
    namespace                             = optional(string)
    period                                = optional(number)
    statistic                             = optional(string)
    threshold                             = optional(number)
    threshold_metric_id                   = optional(string)
    actions_enabled                       = optional(bool)
    alarm_actions                         = optional(set(string))
    alarm_description                     = optional(string)
    datapoints_to_alarm                   = optional(number)
    dimensions                            = optional(map(string))
    insufficient_data_actions             = optional(set(string))
    ok_actions                            = optional(set(string))
    unit                                  = optional(string)
    extended_statistic                    = optional(string)
    treat_missing_data                    = optional(string)
    evaluate_low_sample_count_percentiles = optional(string)
    tags                                  = optional(map(string))
    metric_query = optional(list(object({
      id          = string
      account_id  = optional(string)
      expression  = optional(string)
      label       = optional(string)
      period      = optional(string)
      return_data = optional(bool)
      metric = optional(list(object({
        metric_name = string
        period      = number
        stat        = string
        namespace   = string
        dimensions  = optional(map(string))
        unit        = optional(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "metric_stream" {
  type = list(map(object({
    id            = number
    firehose_arn  = string
    output_format = string
    role_arn      = string
    name          = optional(string)
    name_prefix   = optional(string)
    tags          = optional(map(string))
    include_filter = optional(list(object({
      namespace = optional(string)
    })), [])
    exclude_filter = optional(list(object({
      namespace = optional(string)
    })), [])
    statistics_configuration = optional(list(object({
      additional_statistics = set(string)
      include_metric = list(object({
        metric_name = string
        namespace   = string
      }))
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "resourcegroups_group" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
    tags        = optional(map(string))
    configuration = optional(list(object({
      type = string
      parameters = optional(list(object({
        name   = string
        values = set(string)
      })), [])
    })), [])
    resource_query = optional(list(object({
      query = string
      type  = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "applicationinsights" {
  type = list(map(object({
    id                     = number
    resource_group_id      = number
    auto_config_enabled    = optional(bool)
    auto_create            = optional(bool)
    cwe_monitor_enabled    = optional(bool)
    grouping_type          = optional(string)
    ops_center_enabled     = optional(bool)
    ops_item_sns_topic_arn = optional(string)
    tags                   = optional(map(string))
  })))
  default     = []
  description = <<EOF
EOF
}

variable "evidently_feature" {
  type = list(map(object({
    id                  = number
    name                = string
    project_id          = number
    default_variation   = optional(string)
    description         = optional(string)
    entity_overrides    = optional(map(string))
    evaluation_strategy = optional(string)
    tags                = optional(map(string))
    variations = optional(list(object({
      name = string
      variations = list(object({
        bool_value   = string
        double_value = string
        long_value   = string
        string_value = string
      }))
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "evidently_project" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
    tags        = optional(map(string))
    data_delivery = optional(list(object({
      cloudwatch_logs = optional(list(object({
        log_group = optional(string)
      })), [])
      s3_destination = optional(list(object({
        bucket = optional(string)
        prefix = optional(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "evidently_segment" {
  type = list(map(object({
    id          = number
    name        = string
    pattern     = string
    description = optional(string)
    tags        = optional(map(string))
  })))
  default     = []
  description = <<EOF
EOF
}

variable "log_data_protection_policy" {
  type = list(map(object({
    id              = number
    log_group_id    = number
    policy_document = string
  })))
  default     = []
  description = <<EOF
EOF
}

variable "log_destination" {
  type = list(map(object({
    id         = number
    name       = string
    role_arn   = string
    target_arn = string
  })))
  default     = []
  description = <<EOF
EOF
}

variable "log_destination_policy" {
  type = list(map(object({
    id               = number
    access_policy    = string
    destination_name = string
  })))
}

variable "log_group" {
  type = list(map(object({
    id                = number
    name              = optional(string)
    name_prefix       = optional(string)
    skip_destroy      = optional(bool)
    retention_in_days = optional(number)
    kms_key_id        = optional(string)
    tags              = optional(map(string))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "log_metric_filter" {
  type = list(map(object({
    id           = number
    log_group_id = number
    name         = string
    pattern      = string
    metric_transformation = list(object({
      name          = string
      namespace     = string
      value         = string
      default_value = optional(string)
    }))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "log_resource_policy" {
  type = list(map(object({
    id              = number
    policy_document = string
    policy_name     = string
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "log_stream" {
  type = list(map(object({
    id           = number
    log_group_id = number
    name         = string
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "log_subscription_filter" {
  type = list(map(object({
    id              = number
    destination_arn = string
    filter_pattern  = string
    log_group_id    = number
    name            = string
    role_arn        = optional(string)
    distribution    = optional(string)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "query_definition" {
  type = list(map(object({
    id           = number
    name         = string
    query_string = string
    log_group_id = optional(list(number))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "rum_app_monitor" {
  type = list(map(object({
    id             = number
    domain         = string
    name           = string
    cw_log_enabled = optional(bool)
    tags           = optional(map(string))
    app_monitor_configuration = optional(list(object({
      allow_cookies       = optional(bool)
      enable_xray         = optional(bool)
      excluded_pages      = optional(set(string))
      favorite_pages      = optional(set(string))
      guest_role_arn      = optional(string)
      identity_pool_id    = optional(string)
      included_pages      = optional(set(string))
      session_sample_rate = optional(number)
      telemetries         = optional(set(string))
    })), [])
  })))
  default     = []
  description = <<EOF
EOF
}

variable "rum_metrics_destination" {
  type = list(map(object({
    id              = number
    app_monitor_id  = number
    destination     = string
    destination_arn = optional(string)
    iam_role_arn    = optional(string)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "synthetics_canary" {
  type = list(map(object({
    id = number
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_api_destination" {
  type = list(map(object({
    id                               = number
    connection_arn                   = string
    http_method                      = string
    invocation_endpoint              = string
    name                             = string
    invocation_rate_limit_per_second = optional(number)
    description                      = optional(string)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_archive" {
  type = list(map(object({
    id               = number
    event_source_arn = string
    name             = string
    description      = optional(string)
    event_pattern    = optional(string)
    retention_days   = optional(number)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_bus" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(map(string))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_bus_policy" {
  type = list(map(object({
    id           = number
    policy       = string
    event_bus_id = optional(number)
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_connection" {
  type = list(map(object({
    id                 = number
    authorization_type = string
    name               = string
    description        = optional(string)
    auth_parameters = list(object({
      api_key = optional(list(object({
        key   = string
        value = string
      })), [])
      basic = optional(list(object({
        password = string
        username = string
      })))
      invocation_http_parameters = optional(list(object({
        body = optional(list(object({
          key             = optional(string)
          value           = optional(string)
          is_value_secret = optional(bool)
        })), [])
        header = optional(list(object({
          key             = optional(string)
          value           = optional(string)
          is_value_secret = optional(bool)
        })), [])
        query_string = optional(list(object({
          key             = optional(string)
          value           = optional(string)
          is_value_secret = optional(bool)
        })), [])
      })), [])
      oauth = optional(list(object({
        authorization_endpoint = string
        http_method            = string
        client_parameters = optional(list(object({
          client_id     = string
          client_secret = string
        })), [])
        oauth_http_parameters = optional(list(object({
          body = optional(list(object({
            key             = optional(string)
            value           = optional(string)
            is_value_secret = optional(bool)
          })), [])
          header = optional(list(object({
            key             = optional(string)
            value           = optional(string)
            is_value_secret = optional(bool)
          })), [])
          query_string = optional(list(object({
            key             = optional(string)
            value           = optional(string)
            is_value_secret = optional(bool)
          })), [])
        })), [])
      })), [])
    }))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_permission" {
  type = list(map(object({
    id           = number
    principal    = string
    statement_id = string
    action       = optional(string)
    event_bus_id = optional(number)
    condition = optional(list(object({
      key   = string
      type  = string
      value = string
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_rule" {
  type = list(map(object({
    id                  = number
    name                = optional(string)
    name_prefix         = optional(string)
    schedule_expression = optional(string)
    event_bus_name      = optional(number)
    event_pattern       = optional(string)
    description         = optional(string)
    role_arn            = optional(string)
    is_enabled          = optional(bool)
    state               = optional(string)
    tags                = optional(map(string))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "event_target" {
  type = list(map(object({
    id           = number
    arn          = string
    rule_id      = number
    event_bus_id = optional(number)
    input        = optional(string)
    input_path   = optional(string)
    role_arn     = optional(string)
    target_id    = optional(string)
    batch_target = optional(list(object({
      job_definition = string
      job_name       = string
      array_size     = optional(number)
      job_attempts   = optional(number)
    })), [])
    dead_letter_config = optional(list(object({
      arn = optional(string)
    })), [])
    ecs_target = optional(list(object({
      task_definition_arn = string
      launch_type         = optional(string)
      platform_version    = optional(string)
      task_count          = optional(number)
    })), [])
    input_transformer = optional(list(object({
      input_template = string
      input_paths    = optional(map(string))
    })), [])
    kinesis_target = optional(list(object({
      partition_key_path = optional(string)
    })), [])
    run_command_targets = optional(list(object({
      key    = string
      values = set(string)
    })), [])
    retry_policy = optional(list(object({
      maximum_event_age_in_seconds = optional(number)
      maximum_retry_attempts       = optional(number)
    })), [])
    sqs_target = optional(list(object({
      message_group_id = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
  EOF
}

### CLOUWATCH ###

resource "aws_cloudwatch_composite_alarm" "this" {
  count                     = length(var.composite_alarm)
  alarm_name                = lookup(var.composite_alarm[count.index], "alarm_name")
  alarm_rule                = lookup(var.composite_alarm[count.index], "alarm_rule")
  actions_enabled           = lookup(var.composite_alarm[count.index], "actions_enabled")
  alarm_actions             = lookup(var.composite_alarm[count.index], "alarm_actions")
  alarm_description         = lookup(var.composite_alarm[count.index], "alarm_description")
  insufficient_data_actions = lookup(var.composite_alarm[count.index], "insufficient_data_actions")
  ok_actions                = lookup(var.composite_alarm[count.index], "ok_actions")
  tags = merge(
    var.tags,
    lookup(var.composite_alarm[count.index], "tags")
  )
}

resource "aws_cloudwatch_dashboard" "this" {
  count          = length(var.dashboard)
  dashboard_body = lookup(var.dashboard[count.index], "dashboard_body")
  dashboard_name = lookup(var.dashboard[count.index], "dashboard_name")
}

resource "aws_cloudwatch_metric_alarm" "this" {
  count                                 = length(var.metric_alarm)
  alarm_name                            = lookup(var.metric_alarm[count.index], "alarm_name")
  comparison_operator                   = lookup(var.metric_alarm[count.index], "comparison_operator")
  evaluation_periods                    = lookup(var.metric_alarm[count.index], "evaluation_periods")
  metric_name                           = lookup(var.metric_alarm[count.index], "metric_name")
  namespace                             = lookup(var.metric_alarm[count.index], "namespace")
  period                                = lookup(var.metric_alarm[count.index], "period")
  statistic                             = lookup(var.metric_alarm[count.index], "statistic")
  threshold                             = lookup(var.metric_alarm[count.index], "threshold")
  threshold_metric_id                   = lookup(var.metric_alarm[count.index], "threshold_metric_id")
  actions_enabled                       = lookup(var.metric_alarm[count.index], "actions_enabled")
  alarm_actions                         = lookup(var.metric_alarm[count.index], "alarm_actions")
  alarm_description                     = lookup(var.metric_alarm[count.index], "alarm_description")
  datapoints_to_alarm                   = lookup(var.metric_alarm[count.index], "datapoints_to_alarm")
  dimensions                            = lookup(var.metric_alarm[count.index], "dimensions")
  insufficient_data_actions             = lookup(var.metric_alarm[count.index], "insufficient_data_actions")
  ok_actions                            = lookup(var.metric_alarm[count.index], "ok_actions")
  unit                                  = lookup(var.metric_alarm[count.index], "unit")
  extended_statistic                    = lookup(var.metric_alarm[count.index], "extended_statistic")
  treat_missing_data                    = lookup(var.metric_alarm[count.index], "treat_missing_data")
  evaluate_low_sample_count_percentiles = lookup(var.metric_alarm[count.index], "evaluate_low_sample_count_percentiles")
  tags = merge(
    var.tags,
    lookup(metric_alarm[count.index], "tags")
  )

  dynamic "metric_query" {
    for_each = lookup(var.metric_alarm[count.index], "metric_query") == null ? [] : ["metric_query"]
    content {
      id          = lookup(metric_query.value, "id")
      account_id  = lookup(metric_query.value, "account_id")
      expression  = lookup(metric_query.value, "expression")
      label       = lookup(metric_query.value, "label")
      period      = lookup(metric_query.value, "period")
      return_data = lookup(metric_query.value, "return_data")

      dynamic "metric" {
        for_each = lookup(metric_query.value, "metric") == null ? [] : ["metric"]
        content {
          metric_name = lookup(metric.value, "metric_name")
          period      = lookup(metric.value, "period")
          stat        = lookup(metric.value, "stat")
          namespace   = lookup(metric.value, "namespace")
          dimensions  = lookup(metric.value, "dimensions")
          unit        = lookup(metric.value, "unit")
        }
      }
    }
  }
}

resource "aws_cloudwatch_metric_stream" "this" {
  count         = length(var.metric_stream)
  firehose_arn  = lookup(var.metric_stream[count.index], "firehose_arn")
  output_format = lookup(var.metric_stream[count.index], "output_format")
  role_arn      = lookup(var.metric_stream[count.index], "role_arn")
  name          = lookup(var.metric_stream[count.index], "name")
  name_prefix   = lookup(var.metric_stream[count.index], "name_prefix")
  tags = merge(
    var.tags,
    lookup(var.metric_stream[count.index], "tags")
  )

  dynamic "include_filter" {
    for_each = lookup(var.metric_stream[count.index], "include_filter") == null ? [] : ["include_filter"]
    content {
      namespace = lookup(include_filter.value, "namespace")
    }
  }

  dynamic "exclude_filter" {
    for_each = lookup(var.metric_stream[count.index], "exclude_filter") == null ? [] : ["exclude_filter"]
    content {
      namespace = lookup(exclude_filter.value, "namespace")
    }
  }

  dynamic "statistics_configuration" {
    for_each = lookup(var.metric_stream[count.index], "statistics_configuration") == null ? [] : ["statistics_configuration"]
    content {
      additional_statistics = lookup(statistic_configuration.value, "additional_statistics")
      dynamic "include_metric" {
        for_each = lookup(statistic_configuration.value, "include_metric")
        content {
          metric_name = lookup(include_metric.value, "metric_name")
          namespace   = lookup(include_metric.value, "namespace")
        }
      }
    }
  }
}

#### APPLICATION INSIGHTS ####

resource "aws_resourcegroups_group" "this" {
  count       = length(var.resourcegroups_group)
  name        = lookup(var.resourcegroups_group[count.index], "name")
  description = lookup(var.resourcegroups_group[count.index], "description")
  tags        = merge(var.tags, lookup(var.resourcegroups_group[count.index], "tags"))

  dynamic "configuration" {
    for_each = lookup(var.resourcegroups_group[count.index], "configuration") == null ? [] : ["configuration"]
    content {
      type = lookup(configuration.value, "type")

      dynamic "parameters" {
        for_each = lookup(configuration.value, "parameters") == null ? [] : ["parameters"]
        content {
          name   = lookup(parameters.value, "name")
          values = lookup(parameters.value, "values")
        }
      }
    }
  }

  dynamic "resource_query" {
    for_each = lookup(var.resourcegroups_group[count.index], "resource_query") == null ? [] : ["resource_query"]
    content {
      query = lookup(resource_query.value, "query")
      type  = lookup(resource_query.value, "type")
    }
  }
}

resource "aws_applicationinsights_application" "this" {
  count                  = length(var.applicationinsights) == "0" ? "0" : length(var.resourcegroups_group)
  resource_group_name    = lookup(var.applicationinsights[count.index], "resource_group_name")
  auto_config_enabled    = lookup(var.applicationinsights[count.index], "auto_config_enabled")
  auto_create            = lookup(var.applicationinsights[count.index], "auto_create")
  cwe_monitor_enabled    = lookup(var.applicationinsights[count.index], "cwe_monitor_enabled")
  grouping_type          = lookup(var.applicationinsights[count.index], "grouping_type")
  ops_center_enabled     = lookup(var.applicationinsights[count.index], "ops_center_enabled")
  ops_item_sns_topic_arn = lookup(var.applicationinsights[count.index], "ops_item_sns_topic_arn")
  tags                   = merge(var.tags, lookup(var.applicationinsights[count.index], "tags"))
}

#### EVIDENTLY ####

resource "aws_evidently_feature" "this" {
  count               = length(var.evidently_feature) == "0" ? "0" : length(var.evidently_project)
  name                = lookup(var.evidently_feature[count.index], "name")
  project             = try(elements(aws_evidently_project.this.*.name, lookup(var.evidently_feature[count.index], "project_id")))
  default_variation   = lookup(var.evidently_feature[count.index], "default_variation")
  description         = lookup(var.evidently_feature[count.index], "description")
  entity_overrides    = lookup(var.evidently_feature[count.index], "entity_overrides")
  evaluation_strategy = lookup(var.evidently_feature[count.index], "evaluation_strategy")
  tags                = merge(var.tags, lookup(var.evidently_feature[count.index], "tags"))

  dynamic "variations" {
    for_each = lookup(var.evidently_feature[count.index], "variations") == null ? [] : ["variations"]
    content {
      name = lookup(variations.value, "name")

      dynamic "value" {
        for_each = lookup(variations.value, "value") == null ? [] : ["value"]
        content {
          bool_value   = lookup(value.value, "bool_value")
          double_value = lookup(value.value, "double_value")
          long_value   = lookup(value.value, "long_value")
          string_value = lookup(value.value, "string_value")
        }
      }
    }
  }
}

resource "aws_evidently_project" "this" {
  count       = length(var.evidently_project)
  name        = lookup(var.evidently_project[count.index], "name")
  description = lookup(var.evidently_project[count.index], "description")
  tags        = merge(var.tags, lookup(var.evidently_project[count.index], "tags"))

  dynamic "data_delivery" {
    for_each = lookup(var.evidently_project[count.index], "data_delivery") == null ? [] : ["data_delivery"]
    content {
      dynamic "cloudwatch_logs" {
        for_each = lookup(data_delivery.value, "cloudwatch_logs") == null ? [] : ["cloudwatch_logs"]
        content {
          log_group = lookup(cloudwatch_logs.value, "log_group")
        }
      }

      dynamic "s3_destination" {
        for_each = lookup(data_delivery.value, "s3_destination") == null ? [] : ["s3_destination"]
        content {
          bucket = lookup(s3_destination.value, "bucket")
          prefix = lookup(s3_destination.value, "prefix")
        }
      }
    }
  }
}

resource "aws_evidently_segment" "this" {
  count       = length(var.evidently_segment)
  name        = lookup(var.evidently_segment[count.index], "name")
  pattern     = lookup(var.evidently_segment[count.index], "pattern")
  description = lookup(var.evidently_segment[count.index], "description")
  tags        = merge(var.tags, lookup(var.evidently_segment[count.index], "tags"))
}

#### INTERNET MONITOR ####

/*resource "aws_internetmonitor_monitor" "this" {
  monitor_name = ""
}*/

#### LOGS ####

resource "aws_cloudwatch_log_data_protection_policy" "this" {
  count           = length(var.log_data_protection_policy) == "0" ? "0" : length(var.log_group)
  log_group_name  = try(elements(aws_cloudwatch_log_group.this.*.name, lookup(var.log_data_protection_policy[count.index], "log_group_id")))
  policy_document = lookup(var.log_data_protection_policy[count.index], "policy_document")
}

resource "aws_cloudwatch_log_destination" "this" {
  count      = length(var.log_destination)
  name       = lookup(var.log_destination[count.index], "name")
  role_arn   = lookup(var.log_destination[count.index], "role_arn")
  target_arn = lookup(var.log_destination[count.index], "target_arn")
}

resource "aws_cloudwatch_log_destination_policy" "this" {
  count            = length(var.log_destination_policy)
  access_policy    = lookup(var.log_destination_policy[count.index], "access_policy")
  destination_name = lookup(var.log_destination_policy[count.index], "destination_name")
}

resource "aws_cloudwatch_log_group" "this" {
  count             = length(var.log_group)
  name              = lookup(var.log_group[count.index], "name")
  name_prefix       = lookup(var.log_group[count.index], "name_prefix")
  skip_destroy      = lookup(var.log_group[count.index], "skip_destroy")
  retention_in_days = lookup(var.log_group[count.index], "retention_in_days")
  kms_key_id        = lookup(var.log_group[count.index], "kms_key_id")
  tags              = merge(var.tags, lookup(var.log_group[count.index], "tags"))
}

resource "aws_cloudwatch_log_metric_filter" "this" {
  count          = length(var.log_metric_filter)
  log_group_name = lookup(var.log_metric_filter[count.index], "log_group_name")
  name           = lookup(var.log_metric_filter[count.index], "name")
  pattern        = lookup(var.log_metric_filter[count.index], "pattern")

  dynamic "metric_transformation" {
    for_each = lookup(var.log_metric_filter[count.index], "metric_transformation") == null ? [] : ["metric_transformation"]
    content {
      name          = lookup(metric_transformation.value, "name")
      namespace     = lookup(metric_transformation.value, "namespace")
      value         = lookup(metric_transformation.value, "value")
      default_value = lookup(metric_transformation.value, "default_value")
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "this" {
  count           = length(var.log_resource_policy)
  policy_document = lookup(var.log_resource_policy[count.index], "policy_document")
  policy_name     = lookup(var.log_resource_policy[count.index], "policy_name")
}

resource "aws_cloudwatch_log_stream" "this" {
  count          = length(var.log_stream) == "0" ? "0" : length(var.log_group)
  log_group_name = try(elements(aws_cloudwatch_log_group.this.*.name, lookup(var.log_stream[count.index], "log_group_id")))
  name           = lookup(var.log_stream[count.index], "name")
}

resource "aws_cloudwatch_log_subscription_filter" "this" {
  count           = length(var.log_subscription_filter) == "0" ? "0" : length(var.log_group)
  destination_arn = lookup(var.log_subscription_filter[count.index], "destination_arn")
  filter_pattern  = lookup(var.log_subscription_filter[count.index], "filter_pattern")
  log_group_name  = try(elements(aws_cloudwatch_log_group.this.*.name, lookup(var.log_subscription_filter[count.index], "log_group_id")))
  name            = lookup(var.log_subscription_filter[count.index], "name")
  role_arn        = lookup(var.log_subscription_filter[count.index], "role_arn")
  distribution    = lookup(var.log_subscription_filter[count.index], "distribution")
}

resource "aws_cloudwatch_query_definition" "this" {
  count           = length(var.query_definition) == "0" ? "0" : length(var.log_group)
  name            = lookup(var.query_definition[count.index], "name")
  query_string    = lookup(var.query_definition[count.index], "query_string")
  log_group_names = try(elements(aws_cloudwatch_log_group.this.*.name, lookup(var.query_definition[count.index], "log_group_id")))
}

#### OBSERVABILITY ACCESS MANAGER ####

/*resource "awscc_oam_link" "this" {
  resource_types  = []
  sink_identifier = ""
}

resource "awscc_oam_sink" "this" {
  name = ""
}*/

#### RUM ####

resource "aws_rum_app_monitor" "this" {
  count          = length(var.rum_app_monitor)
  domain         = lookup(var.rum_app_monitor[count.index], "domain")
  name           = lookup(var.rum_app_monitor[count.index], "name")
  cw_log_enabled = lookup(var.rum_app_monitor[count.index], "cw_log_enabled")
  tags = merge(
    var.tags,
    lookup(var.rum_app_monitor[count.index], "tags")
  )

  dynamic "app_monitor_configuration" {
    for_each = lookup(var.rum_app_monitor[count.index], "app_monitor_configuration") == null ? [] : ["app_monitor_configuration"]
    content {
      allow_cookies       = lookup(app_monitor_configuration.value, "allow_cookies")
      enable_xray         = lookup(app_monitor_configuration.value, "enable_xray")
      excluded_pages      = lookup(app_monitor_configuration.value, "excluded_pages")
      favorite_pages      = lookup(app_monitor_configuration.value, "favorite_pages")
      guest_role_arn      = lookup(app_monitor_configuration.value, "guest_role_arn")
      identity_pool_id    = lookup(app_monitor_configuration.value, "identity_pool_id")
      included_pages      = lookup(app_monitor_configuration.value, "included_pages")
      session_sample_rate = lookup(app_monitor_configuration.value, "session_sample_rate")
      telemetries         = lookup(app_monitor_configuration.value, "telemetries")
    }
  }
}

resource "aws_rum_metrics_destination" "this" {
  count            = length(var.rum_metrics_destination)
  app_monitor_name = lookup(var.rum_metrics_destination[count.index], "app_monitor_name")
  destination      = lookup(var.rum_metrics_destination[count.index], "destination")
  destination_arn  = lookup(var.rum_metrics_destination[count.index], "destination_arn")
  iam_role_arn     = lookup(var.rum_metrics_destination[count.index], "iam_role_arn")
}

#### SYNTHETICS ####

resource "aws_synthetics_canary" "this" {
  count                = length(var.synthetics_canary)
  artifact_s3_location = lookup(var.synthetics_canary[count.index], "artifact_s3_location")
  execution_role_arn   = lookup(var.synthetics_canary[count.index], "execution_role_arn")
  handler              = lookup(var.synthetics_canary[count.index], "handler")
  name                 = lookup(var.synthetics_canary[count.index], "name")
  runtime_version      = lookup(var.synthetics_canary[count.index], "runtime_version")
}

#### EVENTBRIDGE ####

resource "aws_cloudwatch_event_api_destination" "this" {
  count                            = length(var.event_api_destination)
  connection_arn                   = lookup(var.event_api_destination[count.index], "connection_arn")
  http_method                      = lookup(var.event_api_destination[count.index], "http_method")
  invocation_endpoint              = lookup(var.event_api_destination[count.index], "invocation_endpoint")
  name                             = lookup(var.event_api_destination[count.index], "name")
  invocation_rate_limit_per_second = lookup(var.event_api_destination[count.index], "invocation_rate_limit_per_second")
  description                      = lookup(var.event_api_destination[count.index], "description")
}

resource "aws_cloudwatch_event_archive" "this" {
  count            = length(var.event_archive)
  event_source_arn = lookup(var.event_archive[count.index], "event_source_arn")
  name             = lookup(var.event_archive[count.index], "name")
  description      = lookup(var.event_archive[count.index], "description")
  event_pattern    = lookup(var.event_archive[count.index], "event_pattern")
  retention_days   = lookup(var.event_archive[count.index], "retention_days")
}

resource "aws_cloudwatch_event_bus" "this" {
  count = length(var.event_bus)
  name  = lookup(var.event_bus[count.index], "name")
  tags = merge(
    var.tags,
    lookup(var.event_bus[count.index], "tags")
  )
}

resource "aws_cloudwatch_event_bus_policy" "this" {
  count          = length(var.event_bus_policy) == "0" ? "0" : length(var.event_bus)
  policy         = lookup(var.event_bus_policy[count.index], "policy")
  event_bus_name = try(elements(aws_cloudwatch_event_bus.this.*.name, lookup(var.event_bus_policy[count.index], "event_bus_id")))
}

resource "aws_cloudwatch_event_connection" "this" {
  count              = length(var.event_connection)
  authorization_type = lookup(var.event_connection[count.index], "authorization_type")
  name               = lookup(var.event_connection[count.index], "name")
  description        = lookup(var.event_connection[count.index], "description")

  dynamic "auth_parameters" {
    for_each = lookup(var.event_connection[count.index], "auth_parameters")
    content {
      dynamic "api_key" {
        for_each = lookup(auth_parameters.value, "api_key") == null ? [] : ["api_key"]
        content {
          key   = lookup(api_key.value, "key")
          value = lookup(api_key.value, "value")
        }
      }
      dynamic "basic" {
        for_each = lookup(auth_parameters.value, "basic") == null ? [] : ["basic"]
        content {
          password = sensitive(basic.value, "password")
          username = sensitive(basic.value, "username")
        }
      }
      dynamic "invocation_http_parameters" {
        for_each = lookup(auth_parameters.value, "invocation_http_parameters") == null ? [] : ["invocation_http_parameters"]
        content {
          dynamic "body" {
            for_each = lookup(invocation_http_parameters.value, "body") == null ? [] : ["body"]
            content {
              key             = lookup(body.value, "key")
              value           = lookup(body.value, "value")
              is_value_secret = lookup(body.value, "is_value_secret")
            }
          }
          dynamic "header" {
            for_each = lookup(invocation_http_parameters.value, "header") == null ? [] : ["header"]
            content {
              key             = lookup(header.value, "key")
              value           = lookup(header.value, "value")
              is_value_secret = lookup(header.value, "is_value_secret")
            }
          }
          dynamic "query_string" {
            for_each = lookup(invocation_http_parameters.value, "query_string") == null ? [] : ["query_string"]
            content {
              key             = lookup(query_string.value, "key")
              value           = lookup(query_string.value, "value")
              is_value_secret = lookup(query_string.value, "is_value_secret")
            }
          }
        }
      }
      dynamic "oauth" {
        for_each = lookup(auth_parameters.value, "oauth") == null ? [] : ["oauth"]
        content {
          authorization_endpoint = lookup(oauth.value, "authorization_endpoint")
          http_method            = lookup(oauth.value, "http_method")
          dynamic "client_parameters" {
            for_each = lookup(oauth.value, "client_parameters") == null ? [] : ["client_parameters"]
            content {
              client_id     = sensitive(lookup(client_parameters.value, "client_id"))
              client_secret = sensitive(lookup(client_parameters.value, "client_secret"))
            }
          }
          dynamic "oauth_http_parameters" {
            for_each = lookup(oauth.value, "oauth_http_parameters") == null ? [] : ["oauth_http_parameters"]
            content {
              dynamic "body" {
                for_each = lookup(oauth_http_parameters.value, "body") == null ? [] : ["body"]
                content {
                  key             = lookup(body.value, "key")
                  value           = lookup(body.value, "value")
                  is_value_secret = lookup(body.value, "is_value_secret")
                }
              }
              dynamic "header" {
                for_each = lookup(oauth_http_parameters.value, "header") == null ? [] : ["header"]
                content {
                  key             = lookup(header.value, "key")
                  value           = lookup(header.value, "value")
                  is_value_secret = lookup(header.value, "is_value_secret")
                }
              }
              dynamic "query_string" {
                for_each = lookup(oauth_http_parameters.value, "query_string") == null ? [] : ["query_string"]
                content {
                  key             = lookup(query_string.value, "key")
                  value           = lookup(query_string.value, "value")
                  is_value_secret = lookup(query_string.value, "is_value_secret")
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "aws_cloudwatch_event_permission" "this" {
  count          = length(var.event_permission) == "0" ? "0" : length(var.event_bus)
  principal      = lookup(var.event_permission[count.index], "principal")
  statement_id   = lookup(var.event_permission[count.index], "statement_id")
  action         = lookup(var.event_permission[count.index], "action")
  event_bus_name = try(elements(aws_cloudwatch_event_bus.this.*.name, lookup(var.event_permission[count.index], "event_bus_id")))

  dynamic "condition" {
    for_each = lookup(var.event_permission[count.index], "condition") == null ? [] : ["condition"]
    content {
      key   = lookup(condition.value, "key")
      type  = lookup(condition.value, "type")
      value = lookup(condition.value, "value")
    }
  }
}

resource "aws_cloudwatch_event_rule" "this" {
  count               = length(var.event_rule) == "0" ? "0" : length(var.event_bus)
  name                = lookup(var.event_rule[count.index], "name")
  name_prefix         = lookup(var.event_rule[count.index], "name_prefix")
  schedule_expression = lookup(var.event_rule[count.index], "schedule_expression")
  event_bus_name      = try(elements(aws_cloudwatch_event_bus.this.*.name, lookup(var.event_rule[count.index], "event_bus_id")))
  event_pattern       = lookup(var.event_rule[count.index], "event_pattern")
  description         = lookup(var.event_rule[count.index], "description")
  role_arn            = lookup(var.event_rule[count.index], "role_arn")
  is_enabled          = lookup(var.event_rule[count.index], "is_enabled")
  state               = lookup(var.event_rule[count.index], "state")
  tags = merge(
    var.tags,
    lookup(var.event_rule[count.index], "tags")
  )
}

resource "aws_cloudwatch_event_target" "this" {
  count          = length(var.event_target) == "0" ? "0" : length(var.event_rule)
  arn            = lookup(var.event_target[count.index], "arn")
  rule           = try(elements(aws_cloudwatch_event_rule.this.*.name, lookup(var.event_target[count.index], "event_rule_id")))
  event_bus_name = try(elements(aws_cloudwatch_event_bus.this.*.name, lookup(var.event_target[count.index], "event_bus_id")))
  input          = lookup(var.event_target[count.index], "input")
  input_path     = lookup(var.event_target[count.index], "input_path")
  role_arn       = lookup(var.event_target[count.index], "role_arn")
  target_id      = lookup(var.event_target[count.index], "target_id")

  dynamic "batch_target" {
    for_each = lookup(var.event_target[count.index], "batch_target") == null ? [] : ["batch_target"]
    content {
      job_definition = lookup(batch_target.value, "job_definition")
      job_name       = lookup(batch_target.value, "job_name")
      array_size     = lookup(batch_target.value, "array_size")
      job_attempts   = lookup(batch_target.value, "job_attempts")
    }
  }

  dynamic "dead_letter_config" {
    for_each = lookup(var.event_target[count.index], "dead_letter_config") == null ? [] : ["dead_letter_config"]
    content {
      arn = lookup(dead_letter_config.value, "arn")
    }
  }

  dynamic "ecs_target" {
    for_each = lookup(var.event_target[count.index], "ecs_target") == null ? [] : ["ecs_target"]
    content {
      task_definition_arn = lookup(ecs_target.value, "task_definition_arn")
      launch_type         = lookup(ecs_target.value, "launch_type")
      platform_version    = lookup(ecs_target.value, "platform_version")
      task_count          = lookup(ecs_target.value, "task_count")
    }
  }

  dynamic "input_transformer" {
    for_each = lookup(var.event_target[count.index], "input_transformer") == null ? [] : ["input_transformer"]
    content {
      input_template = lookup(input_transformer.value, "input_template")
      input_paths    = lookup(input_transformer.value, "input_paths")
    }
  }

  dynamic "kinesis_target" {
    for_each = lookup(var.event_target[count.index], "kinesis_target") == null ? [] : ["kinesis_target"]
    content {
      partition_key_path = lookup(kinesis_target.value, "partition_key_path")
    }
  }

  dynamic "run_command_targets" {
    for_each = lookup(var.event_target[count.index], "run_command_targets") == null ? [] : ["run_command_targets"]
    content {
      key    = lookup(run_command_targets.value, "key")
      values = lookup(run_command_targets.value, "values")
    }
  }

  dynamic "retry_policy" {
    for_each = lookup(var.event_target[count.index], "retry_policy") == null ? [] : ["retry_policy"]
    content {
      maximum_event_age_in_seconds = lookup(retry_policy.value, "maximum_event_age_in_seconds")
      maximum_retry_attempts       = lookup(retry_policy.value, "maximum_retry_attempts")
    }
  }

  dynamic "sqs_target" {
    for_each = lookup(var.event_target[count.index], "sqs_target") == null ? [] : ["sqs_target"]
    content {
      message_group_id = lookup(sqs_target.value, "message_group_id")
    }
  }
}
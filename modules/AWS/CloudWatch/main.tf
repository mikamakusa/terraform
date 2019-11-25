resource "aws_cloudwatch_log_group" "log_group" {
  count             = length(var.log_group)
  name              = lookup(var.log_group[count.index], "name", null)
  retention_in_days = lookup(var.log_group[count.index], "retention_in_days", null)
  kms_key_id        = element(var.kms_key_id, lookup(var.log_group[count.index], "kms_key_id"), null)
  tags              = lookup(var.log_group[count.index], "tags", null)
}

resource "aws_cloudwatch_log_resource_policy" "log_resource_policy" {
  count           = length(var.log_resource_policy)
  policy_document = element(var.policy_document, lookup(var.log_resource_policy[count.index], "policy_document_id"))
  policy_name     = lookup(var.log_resource_policy[count.index], "policy_name")
}

resource "aws_cloudwatch_dashboard" "dashboard" {
  count          = length(var.dashboard)
  dashboard_body = ""
  dashboard_name = lookup(var.dashboard[count.index], "dashboard_name")
}

resource "aws_cloudwatch_event_permission" "event_permission" {
  count        = length(var.event_permission)
  principal    = lookup(var.event_permission[count.index], "principal")
  statement_id = lookup(var.event_permission[count.index], "statement_id")
  action       = lookup(var.event_permission[count.index], "action", null)

  dynamic "condition" {
    for_each = lookup(var.event_permission[count.index], "condition")
    content {
      key   = lookup(condition.value, "key", null)
      type  = lookup(condition.value, "type", null)
      value = lookup(condition.value, "value", null)
    }
  }
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  count               = length(var.event_rule)
  name                = lookup(var.event_rule[count.index], "name", null)
  schedule_expression = lookup(var.event_rule[count.index], "schedule_expression", null)
  event_pattern       = lookup(var.event_rule[count.index], "event_pattern", null) ? aws_cloudwatch_event_rule.event_rule.*.schedule_expression : ""
  description         = lookup(var.event_rule[count.index], "description", null)
  role_arn            = element(var.iam_role_id, lookup(var.event_rule[count.index], "role_id"), null)
  is_enabled          = lookup(var.event_rule[count.index], "is_enabled", false)
  tags                = lookup(var.event_rule[count.index], "tags", null)
}

resource "aws_cloudwatch_event_target" "event_target" {
  count    = length(var.event_rule) == "0" ? "0" : length(var.event_target)
  arn      = element(var.arn, lookup(var.event_target[count.index], "arn_id"))
  rule     = element(aws_cloudwatch_event_rule.event_rule.*.name, lookup(var.event_target[count.index], "rule_id"))
  input    = file(join(".", [join("/", [path.cwd, "input", lookup(var.event_target[count.index], "input")]), "json"]))
  role_arn = element(var.iam_role_id, lookup(var.event_target[count.index], "role_id"))

  dynamic "run_command_targets" {
    for_each = lookup(var.event_target[count.index], "run_command_targets")
    content {
      key    = lookup(run_command_targets.value, "key", null)
      values = [lookup(run_command_targets.value, "values", null)]
    }
  }

  dynamic "ecs_target" {
    for_each = lookup(var.event_target[count.index], "ecs_target")
    content {
      task_definition_arn = element(var.ecs_arn, lookup(ecs_target.value, "task_definition_arn"), null)
    }
  }

  dynamic "batch_target" {
    for_each = lookup(var.event_target[count.index], "batch_target")
    content {
      job_definition = element(var.batch_arn, lookup(batch_target.value, "batch_id"))
      job_name       = lookup(batch_target.value, "job_name")
      array_size     = lookup(batch_target.value, "array_size", null)
      job_attempts   = lookup(batch_target.value, "job_attempts", null)
    }
  }

  dynamic "kinesis_target" {
    for_each = lookup(var.event_target[count.index], "kinesis_target")
    content {
      partition_key_path = file(join(".", [join("/", [path.cwd, lookup(kinesis_target.value, "partition_key_path")]), "json"]), null)
    }
  }

  dynamic "sqs_target" {
    for_each = lookup(var.event_target[count.index], "sqs_target")
    content {
      message_group_id = element(var.sqs_id, lookup(sqs_target.value, "message_group_id"))
    }
  }

  dynamic "input_transformer" {
    for_each = lookup(var.event_target[count.index], "input_transformer")
    content {
      input_template = lookup(input_transformer.value, "input_template", null)
    }
  }
}

resource "aws_cloudwatch_log_destination" "log_destination" {
  count      = length(var.log_destination)
  name       = lookup(var.log_destination[count.index], "name")
  role_arn   = element(var.iam_role_id, lookup(var.log_destination[count.index], "role_id"))
  target_arn = element(var.arn, lookup(var.log_destination[count.index], "target_id"))
}

resource "aws_cloudwatch_log_destination_policy" "destination_policy" {
  count            = length(var.destination_policy)
  access_policy    = file(join(".", [join("/", [path.cwd, lookup(var.destination_policy[count.index], "access_policy")]), "json"]))
  destination_name = lookup(var.destination_policy[count.index], "destination_name")
}

resource "aws_cloudwatch_log_metric_filter" "metric_filter" {
  count          = length(var.log_group) == "0" ? "0" : length(var.metric_filter)
  log_group_name = element(aws_cloudwatch_log_group.log_group.*.name, lookup(var.metric_filter[count.index], "log_group_id"))
  name           = lookup(var.metric_filter[count.index], "name")
  pattern        = lookup(var.metric_filter[count.index], "pattern")

  dynamic "metric_transformation" {
    for_each = lookup(var.metric_filter[count.index], "metric_transformation")
    content {
      name          = lookup(metric_transformation.value, "name")
      namespace     = lookup(metric_transformation.value, "namespace")
      value         = lookup(metric_transformation.value, "value")
      default_value = lookup(metric_transformation.value, "default_value", null)
    }
  }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  count          = length(var.log_group) == "0" ? "0" : length(var.log_stream)
  log_group_name = element(aws_cloudwatch_log_group.log_group.*.name, lookup(var.log_stream[count.index], "log_group_id"))
  name           = lookup(var.log_stream[count.index], "name")
}

resource "aws_cloudwatch_log_subscription_filter" "subscription_filter" {
  count           = length(var.log_group) == "0" ? "0" : length(var.subscription_filter)
  destination_arn = element(var.arn, lookup(var.subscription_filter[count.index], "arn_id"))
  filter_pattern  = lookup(var.subscription_filter[count.index], "filter_pattern")
  log_group_name  = element(aws_cloudwatch_log_group.log_group.*.name, lookup(var.subscription_filter[count.index], "log_group_id"))
  name            = lookup(var.subscription_filter[count.index], "name")
  role_arn        = element(var.iam_role_id, lookup(var.subscription_filter[count.index], "role_id"), null)
  distribution    = lookup(var.subscription_filter[count.index], "distribution", null)
}

resource "aws_cloudwatch_metric_alarm" "metric_alarm" {
  count                                 = length(var.metric_alarm)
  alarm_name                            = lookup(var.metric_alarm[count.index], "alarm_name")
  comparison_operator                   = lookup(var.metric_alarm[count.index], "comparison_operator")
  evaluation_periods                    = lookup(var.metric_alarm[count.index], "evaluation_periods")
  threshold                             = lookup(var.metric_alarm[count.index], "threshold")
  actions_enabled                       = lookup(var.metric_alarm[count.index], "actions_enabled", true)
  alarm_actions                         = [lookup(var.metric_alarm[count.index], "alarm_actions", null)]
  alarm_description                     = lookup(var.metric_alarm[count.index], "alarm_description", null)
  insufficient_data_actions             = [lookup(var.metric_alarm[count.index], "insufficient_data_actions", null)]
  datapoints_to_alarm                   = lookup(var.metric_alarm[count.index], "datapoints_to_alarm", null)
  ok_actions                            = [lookup(var.metric_alarm[count.index], "ok_actions", null)]
  unit                                  = lookup(var.metric_alarm[count.index], "unit", null)
  treat_missing_data                    = lookup(var.metric_alarm[count.index], "unit", null)
  evaluate_low_sample_count_percentiles = lookup(var.metric_alarm[count.index], "evaluate_low_sample_count_percentiles", null)

  dynamic "metric_query" {
    for_each = lookup(var.metric_alarm[count.index], "metric_query")
    content {
      id          = lookup(metric_query.value, "id")
      expression  = lookup(metric_query.value, "expression", null)
      label       = lookup(metric_query.value, "label", null)
      return_data = lookup(metric_query.value, "return_data", null)
    }
  }
}
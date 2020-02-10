resource "aws_cloudwatch_event_target" "event_target" {
  count    = length(var.event_target)
  arn      = element(var.arn, lookup(var.event_target[count.index], "arn_id"))
  rule     = element(var.event_rule_name, lookup(var.event_target[count.index], "rule_id"))
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
      task_definition_arn = element(var.ecs_arn, lookup(ecs_target.value, "task_definition_arn", null))
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
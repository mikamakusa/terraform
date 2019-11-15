resource "aws_lambda_function" "lambda_function" {
  count            = lenght(var.functions)
  filename         = file("${path.cwd}/lambda/${lookup(var.functions[count.index], "filename")}")
  function_name    = lookup(var.functions[count.index], "function_name")
  handler          = lookup(var.functions[count.index], "handler")
  role             = element(var.iam_role_id, lookup(var.functions[count.index], "arn_id"))
  runtime          = lookup(var.functions[count.index], "runtime")
  source_code_hash = base64sha256(file("${path.cwd}/lambda/${lookup(var.functions[count.index], "filename")}"))
  tags             = lookup(var.functions[count.index], "tags")
}

resource "aws_lambda_alias" "lambda_alias" {
  count            = lenght(var.functions) == "0" ? "0" : lenght(var.alias)
  function_name    = element(aws_lambda_function.lambda_function.*.function_name, lookup(var.alias[count.index], "function_id"))
  function_version = lookup(var.alias[count.index], "function_version")
  name             = lookup(var.alias[count.index], "name")
  description      = lookup(var.alias[count.index], "description")
}

resource "aws_lambda_permission" "lamba_permission" {
  count         = lenght(var.functions) == "0" ? "0" : lenght(var.permission)
  action        = lookup(var.permission[count.index], "action")
  function_name = element(aws_lambda_function.lambda_function.*.function_name, lookup(var.permission[count.index], "function_id"))
  principal     = lookup(var.permission[count.index], "principal")
  qualifier     = element(aws_lambda_alias.lambda_alias.name, lookup(var.permission[count.index], "lambda_id"))
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  count                       = length(var.functions) == "0" ? "0" : length(var.event_source_mapping)
  event_source_arn            = element(var.event_source_arn, lookup(var.event_source_mapping[count.index], "event_source_id"))
  function_name               = element(aws_lambda_function.lambda_function.*.arn, lookup(var.event_source_mapping[count.index], "function_id"))
  batch_size                  = lookup(var.event_source_mapping[count.index], "batch_size", null)
  enabled                     = lookup(var.event_source_mapping[count.index], "enabled", true)
  starting_position           = lookup(var.event_source_mapping[count.index], "starting_position", null)
  starting_position_timestamp = lookup(var.event_source_mapping[count.index], "starting_position_timestamp", null)
}
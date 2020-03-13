resource "aws_lambda_permission" "lambda_permission" {
  count         = length(var.lambda_permission)
  action        = "lambda:InvokeFunction"
  function_name = element(var.lambda_function_arn, lookup(var.lambda_permission[count.index], "function_id"))
  principal     = join(".", [lookup(var.lambda_permission[count.index], "source"), "amazonaws.com"])
  source_arn    = lookup(var.lambda_permission[count.index], "source") == "s3" ? element(var.s3_bucket_arn, lookup(var.lambda_permission[count.index], "bucket_id")) : element(var.cloudwatch_event_rule_arn, lookup(var.lambda_permission[count.index], "source_id"))
}
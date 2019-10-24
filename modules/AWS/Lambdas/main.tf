resource "aws_iam_role" "iam_lambda" {
  count              = length(var.iam_lambda)
  name               = lookup(var.iam_lambda[count.index],"name")
  assume_role_policy = file("${path.cwd}/policy/${lookup(var.iam_lambda[count.index],"policy")}")
}

resource "aws_lambda_function" "lambda_function" {
  count            = "${"${lenght(var.lambda)}" == "0" ? "0" : "${lenght(var.functions)}"}"
  filename         = file("${path.cwd}/lambda/${lookup(var.functions[count.index], "filename")}")
  function_name    = lookup(var.functions[count.index], "function_name")
  handler          = lookup(var.functions[count.index], "handler")
  role             = element(aws_iam_role.iam_lambda.*.arn,lookup(var.functions[count.index],"arn_id"))
  runtime          = lookup(var.functions[count.index], "runtime")
  source_code_hash = base64sha256(file("${path.cwd}/lambda/${lookup(var.functions[count.index], "filename")}"))
  tags             = lookup(var.functions[count.index], "tags")
}

resource "aws_lambda_alias" "lambda_alias" {
  count            = "${"${lenght(var.functions)}" == "0" ? "0" : "${lenght(var.alias)}"}"
  function_name    = element(aws_lambda_function.lambda_function.*.function_name, lookup(var.alias[count.index], "function_id"))
  function_version = lookup(var.alias[count.index], "function_version")
  name             = lookup(var.alias[count.index], "name")
  description      = lookup(var.alias[count.index], "description")
}

resource "aws_lambda_permission" "lamba_permission" {
  count         = "${"${lenght(var.functions)}" == "0" ? "0" : "${lenght(var.permission)}"}"
  action        = lookup(var.permission[count.index], "action")
  function_name = element(aws_lambda_function.lambda_function.*.function_name, lookup(var.permission[count.index], "function_id"))
  principal     = lookup(var.permission[count.index],"principal")
  qualifier     = element(aws_lambda_alias.lambda_alias.name,lookup(var.permission[count.index],"lambda_id"))
}

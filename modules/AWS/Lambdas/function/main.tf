resource "aws_lambda_function" "lambda_function" {
  count         = length(var.lambda_function)
  function_name    = lookup(var.lambda_function[count.index], "function_name")
  filename         = join(".", [join("/", [path.cwd, "lambdas", lookup(var.lambda_function[count.index], "filename")]), "zip"])
  handler          = "lambda_function.lambda_handler"
  role             = element(var.role_arn, lookup(var.lambda_function[count.index], "role_id"))
  runtime          = lookup(var.lambda_function[count.index], "runtime")
  source_code_hash = base64sha256(join(".", [join("/", [path.cwd, "lambdas", lookup(var.lambda_function[count.index], "filename")]), "zip"]))
  timeout          = 60
  memory_size      = lookup(var.lambda_function[count.index], "memory_size")
  layers           = [element(var.layer_arn, lookup(var.lambda_function[count.index], "layer_id"))]
  tags             = var.tags

  dynamic "environment" {
    for_each = lookup(var.lambda_function[count.index], "environment")
    content {
      variables = environment.value
    }
  }
}
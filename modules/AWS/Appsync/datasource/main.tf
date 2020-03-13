resource "aws_appsync_datasource" "datasource" {
  count            = length(var.datasource)
  api_id           = element(var.api_id, lookup(var.datasource[count.index], "api_id"))
  name             = lookup(var.datasource[count.index], "name")
  type             = lookup(var.datasource[count.index], "type")
  description      = lookup(var.datasource[count.index], "description")
  service_role_arn = var.service_role_arn

  dynamic "dynamodb_config" {
    for_each = lookup(var.datasource[count.index], "type") == "AMAZON_DYNAMODB" ? lookup(var.datasource[count.index], "dynamodb_config") : null
    content {
      table_name             = var.table_name
      region                 = lookup(dynamodb_config.value, "region", null)
      use_caller_credentials = lookup(dynamodb_config.value, "use_caller_credentials", null)
    }
  }

  dynamic "elasticsearch_config" {
    for_each = lookup(var.datasource[count.index], "type") == "AMAZON_ELASTICSEARCH" ? lookup(var.datasource[count.index], "elasticsearch_config") : null
    content {
      endpoint = var.endpoint
      region   = lookup(elasticsearch_config.value, "region", null)
    }
  }

  dynamic "http_config" {
    for_each = lookup(var.datasource[count.index], "type") == "AMAZON_ELASTICSEARCH" ? lookup(var.datasource[count.index], "http_config") : null
    content {
      endpoint = var.endpoint
    }
  }

  dynamic "lambda_config" {
    for_each = lookup(var.datasource[count.index], "type") == "AWS_LAMBDA" ? lookup(var.datasource[count.index], "lambda_config") : null
    content {
      function_arn = var.function_arn
    }
  }
}
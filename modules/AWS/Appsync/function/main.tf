resource "aws_appsync_function" "function" {
  count                     = length(var.function)
  api_id                    = element(var.api_id, lookup(var.function[count.index], "api_id"))
  data_source               = element(var.data_source, lookup(var.function[count.index], "datasource_id"))
  name                      = lookup(var.function[count.index], "name")
  description               = lookup(var.function[count.index], "description")
  function_version          = "2018-05-29"
  request_mapping_template  = jsonencode(lookup(var.function[count.index], "request_mapping_template"))
  response_mapping_template = jsonencode(lookup(var.function[count.index], "response_mapping_template"))
}
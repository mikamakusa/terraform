resource "aws_appsync_api_key" "api_key" {
  count       = length(var.api_key)
  api_id      = element(var.api_id, lookup(var.api_key[count.index], "api_id"))
  description = lookup(var.api_key[count.index], "description")
  expires     = lookup(var.api_key[count.index], "expires")
}
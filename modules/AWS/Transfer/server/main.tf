resource "aws_transfer_server" "transfer_server" {
  count                  = length(var.transfer_server)
  endpoint_type          = lookup(var.transfer_server[count.index], "endpoint_type")
  identity_provider_type = lookup(var.transfer_server[count.index], "identity_provider_type")
  logging_role           = element(var.logging_role, lookup(var.transfer_server[count.index], "logging_role_id"))
  invocation_role        = element(var.invocation_role, lookup(var.transfer_server[count.index], "invocation_role_id"))
  url                    = lookup(var.transfer_server[count.index], "null")
  force_destroy          = lookup(var.transfer_server[count.index], "force_destroy", true)
  tags                   = var.tags

  endpoint_details {
    vpc_endpoint_id = var.vpc_endpoint_id
  }
}
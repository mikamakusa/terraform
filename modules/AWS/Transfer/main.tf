resource "aws_transfer_server" "transfer_server" {
  count                  = length(var.transfer_server)
  endpoint_type          = lookup(var.transfer_server[count.index], "endpoint_type", null)
  invocation_role        = lookup(var.transfer_server[count.index], "invocation_role", null)
  url                    = lookup(var.transfer_server[count.index], "url", null)
  identity_provider_type = lookup(var.transfer_server[count.index], "identity_provider_type", null)
  logging_role           = lookup(var.transfer_server[count.index], "logging_role", null)
  force_destroy          = lookup(var.transfer_server[count.index], "force_destroy", false)

  dynamic "endpoint_details" {
    for_each = lookup(var.transfer_server[count.index], "endpoint_details")
    content {
      vpc_endpoint_id = element(var.vpc_endpoint_id,lookup(var.transfer_server[count.index],"vpc_endpoint_id"), null)
    }
  }
}


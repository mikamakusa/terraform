resource "aws_iam_openid_connect_provider" "openid_connect_provider" {
  count           = length(var.openid_connect_provider)
  client_id_list  = [lookup(var.openid_connect_provider[count.index], "client_id_list")]
  thumbprint_list = [lookup(var.openid_connect_provider[count.index], "thumprint_list")]
  url             = lookup(var.openid_connect_provider[count.index], "url")
}
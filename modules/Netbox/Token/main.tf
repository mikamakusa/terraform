resource "netbox_token" "token" {
  count = length(var.token)
  user_id       = lookup(var.token[count.index], "user_id")
  allowed_ips   = lookup(var.token[count.index], "allowed_ips")
  key           = sensitive(lookup(var.token[count.index], "key"))
  write_enabled = tobool(lookup(var.token[count.index], "write_enabled"))
}
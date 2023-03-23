resource "netbox_user" "user" {
  count    = length(var.user)
  password = sensitive(lookup(var.user[count.index], "password"))
  username = lookup(var.user[count.index], "username")
  active   = tobool(lookup(var.user[count.index], "active"))
  staff    = tobool(lookup(var.user[count.index], "staff"))
}
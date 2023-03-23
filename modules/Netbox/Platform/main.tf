resource "netbox_platform" "platform" {
  count = length(var.platform)
  name  = lookup(var.platform[count.index], "name")
}
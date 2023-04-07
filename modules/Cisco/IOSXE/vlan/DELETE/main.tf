resource "iosxe_rest" "main" {
  for_each = var.vlan
  method   = "DELETE"
  path     = join("=", ["/data/Cisco-IOS-XE-native:native/vlan/vlan-list", each.value])
}
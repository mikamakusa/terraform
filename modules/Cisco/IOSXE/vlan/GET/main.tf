resource "iosxe_rest" "list" {
  for_each = var.vlan ? 0 : 1
  method   = "GET"
  path     = "/data/Cisco-IOS-XE-native:native/vlan"
}

# Fetch the available VLAN configuration by id
resource "iosxe_rest" "get_id" {
  for_each = var.vlan ? 1 : 0
  method   = "GET"
  path     = join("=", ["/data/Cisco-IOS-XE-native:native/vlan/vlan-list", each.value])
}
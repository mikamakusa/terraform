resource "iosxe_rest" "main" {
  for_each = var.vlan
  method = "POST"
  path   = "/data/Cisco-IOS-XE-native:native/vlan"
  payload = jsonencode(
    {
      "Cisco-IOS-XE-vlan:vlan-list" : {
        "id" : each.value.id,
        "name" : each.key
      }
    }
  )
}
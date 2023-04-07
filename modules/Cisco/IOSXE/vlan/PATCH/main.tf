resource "iosxe_rest" "vlan_example_patch" {
  for_each = var.vlan
  method   = "PATCH"
  path     = "/data/Cisco-IOS-XE-native:native/vlan"
  payload = jsonencode(
    {
      "Cisco-IOS-XE-native:vlan" : {
        "Cisco-IOS-XE-vlan:vlan-list" : [
          {
            "id" : each.value.id
            "name" : each.key
          }
        ]
      }
    }
  )
}
resource "vsphere_custom_attribute" "custom_attribute" {
  for_each            = var.custom_attribute
  name                = each.key
  managed_object_type = each.value.managed_object_type
}
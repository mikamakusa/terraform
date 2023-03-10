resource "vsphere_tag_category" "tag_category" {
  for_each         = var.tag_category
  associable_types = each.value.associable_types
  cardinality      = each.value.cardinality
  name             = each.key
  description      = each.value.description
}
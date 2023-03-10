resource "vsphere_tag" "tag" {
  for_each    = var.tag
  category_id = each.value.category_id
  name        = each.key
  description = each.value.description
}
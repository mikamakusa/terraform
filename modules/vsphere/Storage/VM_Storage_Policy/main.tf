resource "vsphere_vm_storage_policy" "storage_policy" {
  for_each    = var.storage_policy
  name        = each.key
  description = each.value.description

  dynamic "tag_rules" {
    for_each = each.value.tag_rule
    iterator = tag_rule
    content {
      tag_category                 = tag_rule.value.tag_category
      tags                         = tag_rule.value.tags
      include_datastores_with_tags = tag_rule.value.include_datastores_with_tags
    }
  }
}
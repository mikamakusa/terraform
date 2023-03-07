resource "vsphere_content_library_item" "item" {
  for_each    = var.item
  library_id  = each.value.library_id
  name        = each.key
  description = each.value.description
  file_url    = each.value.file_url
  source_uuid = each.value.source_uuid
  type        = each.value.type
}
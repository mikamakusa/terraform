output "tag_id" {
  value = netbox_tag.tag.*.id
}
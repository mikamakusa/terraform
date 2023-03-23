output "site_group_id" {
  value = netbox_site_group.site_group.*.id
}
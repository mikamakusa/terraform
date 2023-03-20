output "site_id" {
  value = netbox_site.site.*.id
}
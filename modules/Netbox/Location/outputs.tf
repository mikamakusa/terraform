output "tenant_id" {
  value = netbox_tenant.tenant.*.id
}

output "site_id" {
  value = netbox_site.site.*.id
}

output "location_id" {
  value = netbox_location.location.*.id
}
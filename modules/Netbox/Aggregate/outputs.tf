output "aggregate_id" {
  value = netbox_aggregate.aggregate.*.id
}

output "rir_id" {
  value = netbox_rir.rir.*.id
}

output "tenant_id" {
  value = netbox_tenant.tenant.*.id
}

output "tenant_group_id" {
  value = netbox_tenant_group.tenant_group.*.id
}
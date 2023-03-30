output "aggregate_id" {
  value = netbox_aggregate.aggregate.*.id
}

output "rir_id" {
  value = netbox_rir.rir.*.id
}
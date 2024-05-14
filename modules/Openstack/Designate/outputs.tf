output "zone" {
  value = try(
    openstack_dns_zone_v2.this.*.id,
    openstack_dns_zone_v2.this.*.name
  )
}

output "transfer_request" {
  value = try(
    openstack_dns_transfer_request_v2.this.*.id,
    openstack_dns_transfer_request_v2.this.*.value_specs,
    openstack_dns_transfer_request_v2.this.*.target_project_id
  )
}

output "transfer_accept" {
  value = try(
    openstack_dns_transfer_accept_v2.this.*.id,
    openstack_dns_transfer_accept_v2.this.*.value_specs,
    openstack_dns_transfer_accept_v2.this.*.zone_transfer_request_id
  )
}

output "recordset" {
  value = try(
    openstack_dns_recordset_v2.this.*.id,
    openstack_dns_recordset_v2.this.*.name,
    openstack_dns_recordset_v2.this.*.zone_id
  )
}
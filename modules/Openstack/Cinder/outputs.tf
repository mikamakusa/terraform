output "qos_association" {
  value = try(
    openstack_blockstorage_qos_association_v3.this.*.id,
    openstack_blockstorage_qos_association_v3.this.*.qos_id,
    openstack_blockstorage_qos_association_v3.this.*.volume_type_id
  )
}

output "quotaset" {
  value = try(
    openstack_blockstorage_quotaset_v3.this.*.id,
    openstack_blockstorage_quotaset_v3.this.*.backup_gigabytes,
    openstack_blockstorage_quotaset_v3.this.*.gigabytes,
    openstack_blockstorage_quotaset_v3.this.*.volume_type_quota
  )
}

output "volume_attach" {
  value = try(
    openstack_blockstorage_volume_attach_v3.this.*.id,
    openstack_blockstorage_volume_attach_v3.this.*.data,
    openstack_blockstorage_volume_attach_v3.this.*.driver_volume_type
  )
}

output "volume_type_access" {
  value = try(
    openstack_blockstorage_volume_type_access_v3.this.*.id
  )
}

output "volume_id" {
  value = try(
    openstack_blockstorage_volume_v3.this.*.id
  )
}
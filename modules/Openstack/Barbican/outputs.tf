output "secret" {
  value = try(
    openstack_keymanager_secret_v1.this.*.name,
    openstack_keymanager_secret_v1.this.*.id,
    openstack_keymanager_secret_v1.this.*.algorithm,
    openstack_keymanager_secret_v1.this.*.bit_length,
    openstack_keymanager_secret_v1.this.*.payload,
    openstack_keymanager_secret_v1.this.*.payload_content_encoding,
    openstack_keymanager_secret_v1.this.*.payload_content_type
  )
}

output "order" {
  value = try(
    openstack_keymanager_order_v1.this.*.id,
    openstack_keymanager_order_v1.this.*.status,
    openstack_keymanager_order_v1.this.*.container_ref,
    openstack_keymanager_order_v1.this.*.type
  )
}

output "container" {
  value = try(
    openstack_keymanager_container_v1.this.*.id,
    openstack_keymanager_container_v1.this.*.name,
    openstack_keymanager_container_v1.this.*.secret_refs
  )
}
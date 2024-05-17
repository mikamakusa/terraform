output "object" {
  value = try(
    openstack_objectstorage_object_v1.this.*.id,
    openstack_objectstorage_object_v1.this.*.name,
    openstack_objectstorage_object_v1.this.*.container_name,
    openstack_objectstorage_object_v1.this.*.content_disposition,
    openstack_objectstorage_object_v1.this.*.content_encoding,
    openstack_objectstorage_object_v1.this.*.content_length,
    openstack_objectstorage_object_v1.this.*.content_type,
    openstack_objectstorage_object_v1.this.*.copy_from,
    openstack_objectstorage_object_v1.this.*.detect_content_type
  )
}

output "container" {
  value = try(
    openstack_objectstorage_container_v1.this.*.id,
    openstack_objectstorage_container_v1.this.*.name,
    openstack_objectstorage_container_v1.this.*.container_read,
    openstack_objectstorage_container_v1.this.*.container_sync_key,
    openstack_objectstorage_container_v1.this.*.container_sync_to,
    openstack_objectstorage_container_v1.this.*.container_write
  )
}

output "tempurl" {
  value = try(
    openstack_objectstorage_tempurl_v1.this.*.id,
    openstack_objectstorage_tempurl_v1.this.*.method,
    openstack_objectstorage_tempurl_v1.this.*.url,
    openstack_objectstorage_tempurl_v1.this.*.ttl
  )
}
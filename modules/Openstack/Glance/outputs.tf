output "image_access" {
  value = try(
    openstack_images_image_access_v2.this.*.id,
    openstack_images_image_access_v2.this.*.image_id,
    openstack_images_image_access_v2.this.*.member_id,
    openstack_images_image_access_v2.this.*.status
  )
}

output "image_access_accept" {
  value = try(
    openstack_images_image_access_accept_v2.this.*.id,
    openstack_images_image_access_accept_v2.this.*.image_id,
    openstack_images_image_access_accept_v2.this.*.member_id,
    openstack_images_image_access_accept_v2.this.*.status
  )
}

output "image" {
  value = try(
    openstack_images_image_v2.this.*.id,
    openstack_images_image_v2.this.*.status,
    openstack_images_image_v2.this.*.name,
    openstack_images_image_v2.this.*.checksum,
    openstack_images_image_v2.this.*.visibility,
    openstack_images_image_v2.this.*.web_download
  )
}
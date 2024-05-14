data "openstack_identity_project_v3" "this" {
  name = var.project_name
}

data "openstack_images_image_v2" "this" {
  name = var.image_name
}

data "openstack_blockstorage_volume_v3" "this" {
  name = var.volume_name
}
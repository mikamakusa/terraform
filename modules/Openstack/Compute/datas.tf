data "openstack_networking_floatingip_v2" "this" {
  count   = var.floatingip ? 1 : 0
  address = var.floatingip
}

data "openstack_images_image_v2" "this" {
  count = var.images ? 1 : 0
  name  = var.images
}

data "openstack_compute_flavor_v2" "this" {
  count = var.flavor ? 1 : 0
  name  = var.flavor
}
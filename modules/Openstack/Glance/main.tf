resource "openstack_images_image_v2" "this" {
  count                 = length(var.image_v2)
  container_format      = lookup(var.image_v2[count.index], "container_format")
  disk_format           = lookup(var.image_v2[count.index], "disk_format")
  name                  = lookup(var.image_v2[count.index], "name")
  local_file_path       = lookup(var.image_v2[count.index], "local_file_path")
  image_cache_path      = lookup(var.image_v2[count.index], "image_cache_path")
  image_source_url      = lookup(var.image_v2[count.index], "image_source_url")
  image_source_username = sensitive(lookup(var.image_v2[count.index], "image_source_username"))
  image_source_password = sensitive(lookup(var.image_v2[count.index], "image_source_password"))
  min_disk_gb           = lookup(var.image_v2[count.index], "min_disk_gb")
  min_ram_mb            = lookup(var.image_v2[count.index], "min_ram_mb")
  image_id              = lookup(var.image_v2[count.index], "image_id")
  properties            = lookup(var.image_v2[count.index], "properties")
  protected             = lookup(var.image_v2[count.index], "protected")
  hidden                = lookup(var.image_v2[count.index], "hidden")
  region                = data.openstack_identity_project_v3.this.region
  tags                  = lookup(var.image_v2[count.index], "tags")
  verify_checksum       = lookup(var.image_v2[count.index], "verify_checksum")
  visibility            = lookup(var.image_v2[count.index], "visibility")
  web_download          = lookup(var.image_v2[count.index], "web_download")
  decompress            = lookup(var.image_v2[count.index], "decompress")
}

resource "openstack_images_image_access_accept_v2" "this" {
  count     = length(var.image_access_accept_v2) == "0" ? "0" : length(var.image_v2)
  image_id  = try(element(openstack_images_image_v2.this.*.id, lookup(var.image_access_accept_v2[count.index], "image_id")))
  status    = lookup(var.image_access_accept_v2[count.index], "status")
  region    = data.openstack_identity_project_v3.this.region
  member_id = lookup(var.image_access_accept_v2[count.index], "member_id")
}

resource "openstack_images_image_access_v2" "this" {
  count     = length(var.image_access_v2) == "0" ? "0" : length(var.image_v2)
  image_id  = try(element(openstack_images_image_v2.this.*.id, lookup(var.image_access_v2[count.index], "image_id")))
  status    = lookup(var.image_access_v2[count.index], "status")
  region    = data.openstack_identity_project_v3.this.region
  member_id = lookup(var.image_access_v2[count.index], "member_id")
}
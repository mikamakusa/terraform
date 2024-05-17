resource "openstack_objectstorage_container_v1" "this" {
  count              = length(var.container_v1)
  name               = lookup(var.container_v1[count.index], "name")
  region             = data.openstack_identity_project_v3.this.region
  container_read     = lookup(var.container_v1[count.index], "container_read")
  container_sync_key = lookup(var.container_v1[count.index], "container_sync_key")
  container_sync_to  = lookup(var.container_v1[count.index], "container_sync_to")
  container_write    = lookup(var.container_v1[count.index], "container_write")
  versioning         = lookup(var.container_v1[count.index], "versioning")
  metadata           = merge(
    var.metadata,
    lookup(var.container_v1[count.index], "metadata")
  )
  content_type       = lookup(var.container_v1[count.index], "content_type")
  storage_policy     = lookup(var.container_v1[count.index], "storage_policy")
  force_destroy      = lookup(var.container_v1[count.index], "force_destroy")
}

resource "openstack_objectstorage_object_v1" "this" {
  count               = length(var.object_v1) == "0" ? "0" : length(var.container_v1)
  container_name      = try(
    element(openstack_objectstorage_container_v1.this.*.name, lookup(var.object_v1[count.index], "container_id"))
  )
  name                = lookup(var.object_v1[count.index], "name")
  content             = lookup(var.object_v1[count.index], "content")
  content_disposition = lookup(var.object_v1[count.index], "content_disposition")
  content_encoding    = lookup(var.object_v1[count.index], "content_encoding")
  content_type        = lookup(var.object_v1[count.index], "content_type")
  copy_from           = lookup(var.object_v1[count.index], "copy_from")
  delete_after        = lookup(var.object_v1[count.index], "delete_after")
  delete_at           = lookup(var.object_v1[count.index], "delete_at")
  detect_content_type = lookup(var.object_v1[count.index], "detect_content_type")
  etag                = lookup(var.object_v1[count.index], "etag")
  object_manifest     = lookup(var.object_v1[count.index], "object_manifest")
  source              = lookup(var.object_v1[count.index], "source")
  region              = data.openstack_identity_project_v3.this.region
}

resource "openstack_objectstorage_tempurl_v1" "this" {
  count      = length(var.tempurl_v1) == "0" ? "0" : (length(var.container_v1) && length(var.object_v1))
  container  = try(
    element(openstack_objectstorage_container_v1.this.*.name, lookup(var.tempurl_v1[count.index], "container_id"))
  )
  object     = try(
    element(openstack_objectstorage_object_v1.this.*.name, lookup(var.tempurl_v1[count.index], "object_id"))
  )
  ttl        = lookup(var.tempurl_v1[count.index], "ttl")
  method     = lookup(var.tempurl_v1[count.index], "method")
  regenerate = lookup(var.tempurl_v1[count.index], "regenerate")
  region     = data.openstack_identity_project_v3.this.region
}
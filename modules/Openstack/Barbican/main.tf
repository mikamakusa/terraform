resource "openstack_keymanager_container_v1" "this" {
  count  = length(var.container_v1)
  type   = lookup(var.container_v1[count.index], "type")
  region = data.openstack_identity_project_v3.this.region
  name   = lookup(var.container_v1[count.index], "name")

  dynamic "secret_refs" {
    for_each = lookup(var.container_v1[count.index], "secret_refs") == null ? [] : ["secret_refs"]
    content {
      secret_ref = try(
        element(openstack_keymanager_secret_v1.this.*.secret_ref, lookup(secrets_refs.value, "secret_id"))
      )
      name       = lookup(secrets_refs.value, "name")
    }
  }

  dynamic "acl" {
    for_each = lookup(var.container_v1[count.index], "acl") == null ? [] : ["acl"]
    content {
      dynamic "read" {
        for_each = lookup(acl.value, "read") == null ? [] : ["read"]
        content {
          project_access = lookup(read.value, "project_access")
          users          = lookup(read.value, "users")
        }
      }
    }
  }
}

resource "openstack_keymanager_order_v1" "this" {
  count  = length(var.order_v1)
  type   = lookup(var.order_v1[count.index], "type")
  region = data.openstack_identity_project_v3.this.region

  dynamic "meta" {
    for_each = lookup(var.order_v1[count.index], "meta") == null ? [] : ["meta"]
    content {
      algorithm            = lookup(meta.value, "algorithm")
      bit_length           = lookup(meta.value, "bit_length")
      expiration           = lookup(meta.value, "expiration")
      mode                 = lookup(meta.value, "mode")
      payload_content_type = lookup(meta.value, "payload_content_type")
    }
  }
}

resource "openstack_keymanager_secret_v1" "this" {
  count                    = length(var.secret_v1)
  region                   = data.openstack_identity_project_v3.this.region
  name                     = lookup(var.secret_v1[count.index], "name")
  bit_length               = lookup(var.secret_v1[count.index], "bit_length")
  algorithm                = lookup(var.secret_v1[count.index], "algorithm")
  mode                     = lookup(var.secret_v1[count.index], "mode")
  secret_type              = lookup(var.secret_v1[count.index], "secret_type")
  payload                  = lookup(var.secret_v1[count.index], "payload")
  payload_content_encoding = lookup(var.secret_v1[count.index], "payload_content_encoding")
  payload_content_type     = lookup(var.secret_v1[count.index], "payload_content_type")
  expiration               = lookup(var.secret_v1[count.index], "expiration")
  metadata                 = merge(
    var.metadata,
    lookup(var.secret_v1[count.index], "metadata")
  )

  dynamic "acl" {
    for_each = lookup(var.secret_v1[count.index], "acl") == null ? [] : ["acl"]
    content {
      dynamic "read" {
        for_each = lookup(acl.value, "read") == null ? [] : ["read"]
        content {
          project_access = lookup(read.value, "project_access")
          users          = lookup(read.value, "users")
        }
      }
    }
  }
}
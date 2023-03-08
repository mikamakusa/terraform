resource "vsphere_entity_permissions" "entity_permission" {
  entity_id   = var.permission.entity_id
  entity_type = var.permission.entity_type

  dynamic "permissions" {
    for_each = var.permission.permission
    iterator = permission
    content {
      is_group = permission.value.is_group
      propagate = permission.value.propagate
      role_id = permission.value.role_id
      user_or_group = permission.value.user_or_group
    }
  }
}
resource "vsphere_role" "role" {
  for_each        = var.role
  name            = each.key
  role_privileges = each.value.role_privileges
}
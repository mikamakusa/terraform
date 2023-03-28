resource "aci_authentication_properties" "authentication_properties" {
  for_each        = var.authentication_properties
  annotation      = each.value.annotation
  description     = each.value.description
  def_role_policy = each.value.def_role_policy
  name_alias      = each.value.name_alias
  ping_check      = each.value.ping_check
  retries         = each.value.retries
  timeout         = each.value.timeout
}
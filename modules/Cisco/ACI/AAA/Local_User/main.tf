resource "aci_local_user" "local_user" {
  for_each            = var.local_user
  name                = each.key
  account_status      = each.value.account_status
  annotation          = each.value.annotation
  cert_attribute      = each.value.cert_attribute
  clear_pwd_history   = each.value.clear_pwd_history
  description         = each.value.description
  email               = each.value.email
  expiration          = each.value.expiration
  expires             = each.value.expires
  first_name          = each.value.first_name
  last_name           = each.value.last_name
  name_alias          = each.value.name_alias
  otpenable           = each.value.otpenable
  otpkey              = each.value.otpkey
  phone               = each.value.phone
  pwd                 = sensitive(each.value.pwd)
  pwd_life_time       = each.value.pwd_life_time
  pwd_update_required = each.value.pwd_update_required
  rbac_string         = each.value.rbac_string
}
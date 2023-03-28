resource "aci_global_security" "global_security" {
  for_each                   = var.global_security
  name_alias                 = each.key
  annotation                 = each.value.annotation
  description                = each.value.description
  pwd_strength_check         = each.value.pwd_strength_check
  change_count               = each.value.change_count
  change_during_interval     = each.value.change_during_interval
  change_interval            = each.value.change_interval
  expiration_warn_time       = each.value.expiration_warn_time
  history_count              = each.value.history_count
  no_change_interval         = each.value.no_change_interval
  block_duration             = each.value.block_duration
  max_failed_attempts        = each.value.max_failed_attempts
  max_failed_attempts_window = each.value.max_failed_attempts_window
  maximum_validity_period    = each.value.maximum_validity_period
  session_record_flags       = each.value.session_record_flags
  ui_idle_timeout_seconds    = each.value.ui_idle_timeout_seconds
  webtoken_timeout_seconds   = each.value.webtoken_timeout_seconds
  relation_aaa_rs_to_user_ep = each.value.relation_aaa_rs_to_user_ep
}
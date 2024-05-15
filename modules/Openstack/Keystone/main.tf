resource "openstack_identity_project_v3" "this" {
  count       = length(var.project_v3)
  name        = lookup(var.project_v3[count.index], "name")
  description = lookup(var.project_v3[count.index], "description")
  domain_id   = lookup(var.project_v3[count.index], "domain_id")
  enabled     = lookup(var.project_v3[count.index], "enabled")
  is_domain   = lookup(var.project_v3[count.index], "is_domain")
  parent_id   = lookup(var.project_v3[count.index], "parent_id")
  region      = lookup(var.project_v3[count.index], "region")
  tags        = lookup(var.project_v3[count.index], "tags")
}

resource "openstack_identity_application_credential_v3" "this" {
  count        = length(var.application_credential_v3)
  name         = lookup(var.application_credential_v3[count.index], "name")
  region       = try(data.openstack_identity_project_v3.this.region, lookup(var.application_credential_v3[count.index], "region"))
  description  = lookup(var.application_credential_v3[count.index], "description")
  unrestricted = lookup(var.application_credential_v3[count.index], "unrestricted")
  secret       = lookup(var.application_credential_v3[count.index], "secret")
  roles        = lookup(var.application_credential_v3[count.index], "roles")
  expires_at   = lookup(var.application_credential_v3[count.index], "expires_at")

  dynamic "access_rules" {
    for_each = lookup(var.application_credential_v3[count.index], "access_rules") == null ? [] : ["access_rules"]
    content {
      method  = lookup(access_rules.value, "method")
      path    = lookup(access_rules.value, "path")
      service = lookup(access_rules.value, "service")
    }
  }
}

resource "openstack_identity_ec2_credential_v3" "this" {
  count      = length(var.ec2_credential_v3)
  region     = var.project_name != null ? data.openstack_identity_project_v3.this.region : try(element(openstack_identity_project_v3.this.*.region, lookup(var.ec2_credential_v3[count.index], "project_id")))
  project_id = var.project_name != null ? data.openstack_identity_project_v3.this.region : try(element(openstack_identity_project_v3.this.*.id, lookup(var.ec2_credential_v3[count.index], "project_id")))
  user_id    = try(element(openstack_identity_user_v3.this.*.id, lookup(var.ec2_credential_v3[count.index], "user_id")))
}

resource "openstack_identity_endpoint_v3" "this" {
  count           = length(var.endpoint_v3) == "0" ? "0" : length(var.service_v3)
  endpoint_region = try(element(openstack_identity_service_v3.this.*.region, lookup(var.service_v3[count.index], "service_id")))
  service_id      = try(element(openstack_identity_service_v3.this.*.id, lookup(var.service_v3[count.index], "service_id")))
  url             = lookup(var.service_v3[count.index], "url")
  name            = lookup(var.service_v3[count.index], "name")
}

resource "openstack_identity_group_v3" "this" {
  count       = length(var.group_v3)
  name        = lookup(var.group_v3[count.index], "name")
  description = lookup(var.group_v3[count.index], "description")
  domain_id   = lookup(var.group_v3[count.index], "domain_id")
  region      = var.project_name != null ? data.openstack_identity_project_v3.this.region : try(element(openstack_identity_service_v3.this.*.region, lookup(var.group_v3[count.index], "project_id")))
}

resource "openstack_identity_inherit_role_assignment_v3" "this" {
  count      = length(var.inherit_role_assignment_v3) == "0" ? "0" : length(var.role_v3)
  role_id    = try(element(openstack_identity_role_v3.this.*.id, lookup(var.inherit_role_assignment_v3[count.index], "role_id")))
  domain_id  = lookup(var.inherit_role_assignment_v3[count.index], "domain_id")
  group_id   = try(element(openstack_identity_group_v3.this.*.id, lookup(var.inherit_role_assignment_v3[count.index], "group_id")))
  project_id = var.project_name != null ? data.openstack_identity_project_v3.this.region : try(element(openstack_identity_service_v3.this.*.region, lookup(var.inherit_role_assignment_v3[count.index], "project_id")))
  user_id    = try(element(openstack_identity_user_v3.this.*.id, lookup(var.inherit_role_assignment_v3[count.index], "user_id")))
}

resource "openstack_identity_role_assignment_v3" "this" {
  count      = length(var.role_assignment_v3) == "0" ? "0" : length(var.role_v3)
  role_id    = try(element(openstack_identity_role_v3.this.*.id, lookup(var.role_assignment_v3[count.index], "role_id")))
  domain_id  = lookup(var.role_assignment_v3[count.index], "domain_id")
  group_id   = try(element(openstack_identity_group_v3.this.*.id, lookup(var.role_assignment_v3[count.index], "group_id")))
  project_id = var.project_name != null ? data.openstack_identity_project_v3.this.id : try(element(openstack_identity_service_v3.this.*.region, lookup(var.role_assignment_v3[count.index], "project_id")))
  user_id    = try(element(openstack_identity_user_v3.this.*.id, lookup(var.role_assignment_v3[count.index], "user_id")))
}

resource "openstack_identity_role_v3" "this" {
  count     = length(var.role_v3)
  name      = lookup(var.role_v3[count.index], "name")
  domain_id = lookup(var.role_v3[count.index], "domain_id")
  region    = var.project_name != null ? data.openstack_identity_project_v3.this.region : try(element(openstack_identity_service_v3.this.*.region, lookup(var.role_v3[count.index], "project_id")))
}

resource "openstack_identity_service_v3" "this" {
  count       = length(var.service_v3)
  name        = lookup(var.service_v3[count.index], "name")
  type        = lookup(var.service_v3[count.index], "type")
  region      = var.project_name != null ? data.openstack_identity_project_v3.this.region : try(element(openstack_identity_service_v3.this.*.region, lookup(var.service_v3[count.index], "project_id")))
  description = lookup(var.service_v3[count.index], "description")
  enabled     = lookup(var.service_v3[count.index], "enabled")
}

resource "openstack_identity_user_membership_v3" "this" {
  count    = length(var.user_membership_v3) == "0" ? "0" : (length(var.user_v3) && length(var.group_v3))
  group_id = try(element(openstack_identity_group_v3.this.*.id, lookup(var.user_membership_v3[count.index], "group_id")))
  user_id  = try(element(openstack_identity_user_v3.this.*.id, lookup(var.user_membership_v3[count.index], "user_id")))
  region   = var.project_name != null ? data.openstack_identity_project_v3.this.region : try(element(openstack_identity_service_v3.this.*.region, lookup(var.user_membership_v3[count.index], "project_id")))
}

resource "openstack_identity_user_v3" "this" {
  count                                 = length(var.user_v3)
  description                           = lookup(var.user_v3[count.index], "description")
  default_project_id                    = lookup(var.user_v3[count.index], "default_project_id")
  domain_id                             = lookup(var.user_v3[count.index], "domain_id")
  enabled                               = lookup(var.user_v3[count.index], "enabled")
  extra                                 = lookup(var.user_v3[count.index], "extra")
  ignore_change_password_upon_first_use = lookup(var.user_v3[count.index], "ignore_change_password_upon_first_use")
  ignore_lockout_failure_attempts       = lookup(var.user_v3[count.index], "ignore_lockout_failure_attempts")
  ignore_password_expiry                = lookup(var.user_v3[count.index], "ignore_password_expiry")
  multi_factor_auth_enabled             = lookup(var.user_v3[count.index], "multi_factor_auth_enabled")
  name                                  = sensitive(lookup(var.user_v3[count.index], "name"))
  password                              = sensitive(lookup(var.user_v3[count.index], "password"))
  region                                = var.project_name != null ? data.openstack_identity_project_v3.this.region : try(element(openstack_identity_service_v3.this.*.region, lookup(var.user_v3[count.index], "default_project_id")))

  dynamic "multi_factor_auth_rule" {
    for_each = lookup(var.user_v3[count.index], "multi_factor_auth_rule") == null ? [] : ["multi_factor_auth_rule"]
    content {
      rule = lookup(multi_factor_auth_rule.value, "rule")
    }
  }
}
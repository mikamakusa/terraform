resource "google_access_context_manager_access_policy" "this" {
  count  = var.access_policy == null ? 0 : 1
  parent = var.access_policy.parent
  title  = var.access_policy.title
  scopes = var.access_policy.scopes
}

resource "google_access_context_manager_access_level" "this" {
  count       = var.access_level == null ? 0 : 1
  name        = var.access_level.name
  parent      = var.access_level.parent
  title       = var.access_level.title
  description = var.access_level.description

  dynamic "basic" {
    for_each = var.access_level.basic == null ? [] : [""]
    content {
      combining_function = var.access_level.basic.combining_function

      dynamic "conditions" {
        for_each = var.access_level.basic.conditions == null ? [] : [""]
        content {
          required_access_levels = var.access_level.basic.conditions.required_access_levels
          ip_subnetworks         = var.access_level.basic.conditions.ip_subnetworks
          members                = var.access_level.basic.conditions.members
          negate                 = var.access_level.basic.conditions.negate
          regions                = var.access_level.basic.conditions.regions

          dynamic "device_policy" {
            for_each = var.access_level.basic.conditions.device_policy == null ? [] : [""]
            content {
              require_screen_lock              = var.access_level.basic.conditions.device_policy.require_screen_lock
              require_admin_approval           = var.access_level.basic.conditions.device_policy.require_admin_approval
              require_corp_owned               = var.access_level.basic.conditions.device_policy.require_corp_owned
              allowed_device_management_levels = var.access_level.basic.conditions.device_policy.allowed_device_management_levels
              allowed_encryption_statuses      = var.access_level.basic.conditions.device_policy.allowed_encryption_statuses

              dynamic "os_constraints" {
                for_each = var.access_level.basic.conditions.device_policy.os_constraints == null ? [] : [""]
                content {
                  os_type                    = var.access_level.basic.conditions.device_policy.os_constraints.os_type
                  minimum_version            = var.access_level.basic.conditions.device_policy.os_constraints.minimum_version
                  require_verified_chrome_os = var.access_level.basic.conditions.device_policy.os_constraints.required_verified_chrome_os
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "google_access_context_manager_access_level_condition" "this" {
  count                  = var.access_level == null ? 0 : 1
  access_level           = google_access_context_manager_access_level.this.name
  ip_subnetworks         = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.ip_subnetworks
  required_access_levels = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.required_access_levels
  members                = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.members
  negate                 = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.negate
  regions                = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.regions

  dynamic "device_policy" {
    for_each = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.device_policy
    content {
      require_admin_approval           = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.device_policy.require_admin_approval
      require_corp_owned               = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.device_policy.require_corp_owned
      require_screen_lock              = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.device_policy.require_screen_lock
      allowed_device_management_levels = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.device_policy.allowed_device_management_levels
      allowed_encryption_statuses      = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.device_policy.allowed_encryption_statuses

      dynamic "os_constraints" {
        for_each = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.device_policy.os_constraints
        content {
          os_type         = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.device_policy.os_constraints.os_type
          minimum_version = var.access_level.basic.conditions == null ? null : var.access_level.basic.conditions.device_policy.os_constraints.minimum_version
        }
      }
    }
  }
}

resource "google_access_context_manager_access_policy_iam_binding" "this" {
  count   = length(var.members)
  members = var.members
  name    = google_access_context_manager_access_policy.this.name
  role    = "roles/accesscontextmanager.policyAdmin"
}

resource "google_access_context_manager_authorized_orgs_desc" "this" {
  count                   = var.authorized_orgs_desc == null ? 0 : 1
  name                    = join("/", ["accessPolicies", google_access_context_manager_access_policy.this.name, "authorizedOrgsDescs", var.authorized_orgs_desc.name])
  parent                  = join("/", ["accessPolicies", google_access_context_manager_access_policy.this.name])
  orgs                    = var.authorized_orgs_desc.orgs
  authorization_direction = var.authorized_orgs_desc.authorization_direction
  authorization_type      = "AUTHORIZATION_TYPE_TRUST"
}

resource "google_access_context_manager_gcp_user_access_binding" "this" {
  count           = var.user_access_binding == null ? 0 : 1
  access_levels   = var.user_access_binding.access_levels
  group_key       = var.user_access_binding.group_key
  organization_id = var.user_access_binding.organization_id
}

resource "google_access_context_manager_service_perimeter" "this" {
  count                     = var.service_perimeter == null ? 0 : 1
  name                      = var.service_perimeter.name
  parent                    = var.service_perimeter.parent
  title                     = var.service_perimeter.title
  description               = var.service_perimeter.description
  perimeter_type            = var.service_perimeter.perimeter_type
  use_explicit_dry_run_spec = var.service_perimeter.use_explicitly_dry_run_spec

  dynamic "status" {
    for_each = var.service_perimeter.status == null ? [] : [""]
    content {
      resources           = var.service_perimeter.status.resources
      access_levels       = var.service_perimeter.status.access_levels
      restricted_services = var.service_perimeter.status.restricted_services

      dynamic "vpc_accessible_services" {
        for_each = var.service_perimeter.status.vpc_accessible_services == null ? [] : [""]
        content {
          allowed_services   = var.service_perimeter.status.vpc_accessible_services.allowed_services
          enable_restriction = var.service_perimeter.status.vpc_accessible_services.enable_restrictions
        }
      }

      dynamic "ingress_policies" {
        for_each = var.service_perimeter.status.ingress_policies == null ? [] : [""]
        content {
          dynamic "ingress_from" {
            for_each = var.service_perimeter.status.ingress_policies.ingress_from == null ? [] : [""]
            content {
              identity_type = var.service_perimeter.status.ingress_policies.ingress_from.identity_type
              identities    = var.service_perimeter.status.ingress_policies.ingress_from.identities

              dynamic "sources" {
                for_each = var.service_perimeter.status.ingress_policies.ingress_from.sources == null ? [] : [""]
                content {
                  access_level = var.service_perimeter.status.ingress_policies.ingress_from.sources.access_level
                  resource     = var.service_perimeter.status.ingress_policies.ingress_from.sources.resource
                }
              }
            }
          }
          dynamic "ingress_to" {
            for_each = var.service_perimeter.status.ingress_policies.ingress_to == null ? [] : [""]
            content {
              resources = var.service_perimeter.status.ingress_policies.ingress_to.resources

              dynamic "operations" {
                for_each = var.service_perimeter.status.ingress_policies.ingress_to.operations == null ? [] : [""]
                content {
                  service_name = var.service_perimeter.status.ingress_policies.ingress_to.operations.service_name

                  dynamic "method_selectors" {
                    for_each = var.service_perimeter.status.ingress_policies.ingress_to.operations.method_selectors == null ? [] : [""]
                    content {
                      method     = var.service_perimeter.status.ingress_policies.ingress_to.operations.method_selectors.method
                      permission = var.service_perimeter.status.ingress_policies.ingress_to.operations.method_selectors.permission
                    }
                  }
                }
              }
            }
          }

        }
      }

      dynamic "egress_policies" {
        for_each = var.service_perimeter.status.egress_policies == null ? [] : [""]
        content {
          dynamic "egress_from" {
            for_each = var.service_perimeter.status.egress_policies.egress_from == null ? [] : [""]
            content {
              identities    = var.service_perimeter.status.egress_policies.egress_from.identities
              identity_type = var.service_perimeter.status.egress_policies.egress_from.identity_type
            }
          }
          dynamic "egress_to" {
            for_each = var.service_perimeter.status.egress_policies.egress_to == null ? [] : [""]
            content {
              resources = var.service_perimeter.status.egress_policies.egress_to.resources

              dynamic "operations" {
                for_each = var.service_perimeter.status.egress_policies.egress_to.operations == null ? [] : [""]
                content {
                  service_name = var.service_perimeter.status.egress_policies.egress_to.operations.service_name

                  dynamic "method_selectors" {
                    for_each = var.service_perimeter.status.egress_policies.egress_to.operations.method_selectors == null ? [] : [""]
                    content {
                      method     = var.service_perimeter.status.egress_policies.egress_to.operations.method_selectors.method
                      permission = var.service_perimeter.status.egress_policies.egress_to.operations.method_selectors.permission
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "google_access_context_manager_service_perimeter_resource" "this" {
  count          = var.perimeter_resource == null ? 0 : 1
  perimeter_name = var.perimeter_resource.perimeter_name
  resource       = var.perimeter_resource.resource
}
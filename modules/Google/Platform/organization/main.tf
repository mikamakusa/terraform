resource "google_organization_policy" "organization_policy_boolean" {
  count      = length(var.organization_policy_boolean)
  constraint = lookup(var.organization_policy_boolean[count.index], "constraint")
  org_id     = lookup(var.organization_policy_boolean[count.index], "org_id")
  version    = lookup(var.organization_policy_boolean[count.index], "version")

  dynamic "boolean_policy" {
    for_each = lookup(var.organization_policy_boolean[count.index], "boolean_policy")
    content {
      enforced = lookup(boolean_policy.value, "enforced")
    }
  }
}

resource "google_organization_policy" "organization_policy_list" {
  count      = length(var.organization_policy_list)
  constraint = lookup(var.organization_policy_list[count.index], "constraint")
  org_id     = lookup(var.organization_policy_list[count.index], "org_id")
  version    = lookup(var.organization_policy_list[count.index], "version")

  dynamic "list_policy" {
    for_each = [for policy in lookup(var.organization_policy_list[count.index], "list_policy") : {
      inherit   = policy.inherit_from_parent
      suggested = policy.suggested_value
      allow     = lookup(policy, "allow")
      deny      = lookup(policy, "deny")
    }]
    content {
      dynamic "allow" {
        for_each = [for i in list_policy.value.allow : {
          all    = i.all
          values = i.values
        }]
        content {
          all    = allow.value.all
          values = allow.value.values
        }
      }
      dynamic "deny" {
        for_each = [for i in list_policy.value.deny : {
          all    = i.all
          values = i.values
        }]
        content {
          all    = deny.value.all
          values = deny.value.values
        }
      }
      inherit_from_parent = list_policy.value.inherit
      suggested_value     = list_policy.value.suggested
    }
  }
}

resource "google_organization_policy" "organization_policy_restore" {
  count      = length(var.organization_policy_restore)
  constraint = lookup(var.organization_policy_restore[count.index], "constraint")
  org_id     = lookup(var.organization_policy_restore[count.index], "org_id")
  version    = lookup(var.organization_policy_restore[count.index], "version")

  dynamic "restore_policy" {
    for_each = lookup(var.organization_policy_restore[count.index], "restore_policy")
    content {
      default = lookup(restore_policy.value, "default")
    }
  }
}

resource "google_organization_iam_policy" "organization_iam_policy" {
  count       = length(var.organization_iam_policy)
  org_id      = lookup(var.organization_iam_policy[count.index], "org_id")
  policy_data = element(var.policy_data, lookup(var.organization_iam_policy[count.index], "policy_id"))
}

resource "google_organization_iam_member" "organization_iam_member" {
  count  = length(var.organization_iam_member)
  member = lookup(var.organization_iam_member[count.index], "member")
  org_id = lookup(var.organization_iam_member[count.index], "org_id")
  role   = lookup(var.organization_iam_member[count.index], "role")
}

resource "google_organization_iam_binding" "organization_iam_binding" {
  count   = length(var.organization_iam_binding)
  members = lookup(var.organization_iam_binding[count.index], "members")
  org_id  = lookup(var.organization_iam_binding[count.index], "org_id")
  role    = lookup(var.organization_iam_binding[count.index], "role")
}

resource "google_organization_iam_custom_role" "organization_iam_custom_role" {
  count       = length(var.organization_iam_custom_role)
  org_id      = lookup(var.organization_iam_custom_role[count.index], "org_id")
  permissions = lookup(var.organization_iam_custom_role[count.index], "permissions")
  role_id     = lookup(var.organization_iam_custom_role[count.index], "role_id")
  title       = lookup(var.organization_iam_custom_role[count.index], "title")
}
resource "google_folder" "folder" {
  count        = length(var.folder)
  display_name = lookup(var.folder[count.index], "display_name")
  parent       = lookup(var.folder[count.index], "parent")
}

resource "google_folder_iam_binding" "folder_iam_binding" {
  count   = length(var.folder_iam_binding)
  folder  = element(google_folder.folder.*.name, lookup(var.folder_iam_binding[count.index], "folder_id"))
  members = lookup(var.folder_iam_binding[count.index], "members")
  role    = lookup(var.folder_iam_binding[count.index], "role")
}

resource "google_folder_iam_member" "folder_iam_member" {
  count  = length(var.folder_iam_member)
  folder = element(google_folder.folder.*.name, lookup(var.folder_iam_member[count.index], "folder_id"))
  member = lookup(var.folder_iam_member[count.index], "members")
  role   = lookup(var.folder_iam_member[count.index], "role")
}

resource "google_folder_iam_policy" "folder_iam_policy" {
  count       = length(var.folder_iam_policy)
  folder      = element(google_folder.folder.*.name, lookup(var.folder_iam_policy[count.index], "folder_id"))
  policy_data = element(var.policy_template, lookup(var.folder_iam_policy[count.index], "policy_id"))
}

resource "google_folder_organization_policy" "folder_organization_policy" {
  count      = length(var.folder_organization_policy)
  constraint = lookup(var.folder_organization_policy[count.index], "constraint")
  folder     = lookup(var.folder_organization_policy[count.index], "folder")
  version    = lookup(var.folder_organization_policy[count.index], "version")

  dynamic "boolean_policy" {
    for_each = lookup(var.folder_organization_policy[count.index], "list_policy") || lookup(var.folder_organization_policy[count.index], "list_policy") == [] ? lookup(var.folder_organization_policy[count.index], "boolean_policy") : []
    content {
      enforced = lookup(boolean_policy.value, "enforced", false)
    }
  }

  dynamic "list_policy" {
    for_each = lookup(var.folder_organization_policy[count.index], "boolean_policy") || lookup(var.folder_organization_policy[count.index], "restore_policy") != [] ? [] : [for i in lookup(var.folder_organization_policy[count.index], "list_policy") : {
      allow     = lookup(i, "allow", null)
      deny      = lookup(i, "deny", null)
      suggested = i.suggested_value
      inherit   = i.inherit_from_parent
    }]
    content {
      dynamic "allow" {
        for_each = list_policy.value.allow == null ? [] : [for i in list_policy.value.allow : {
          all   = i.all
          value = i.values
        }]
        content {
          all    = allow.value.all
          values = allow.value.values
        }
      }
      dynamic "deny" {
        for_each = list_policy.value.deny == null ? [] : [for i in list_policy.value.deny : {
          all    = i.all
          values = i.values
        }]
        content {
          all    = deny.value.all
          values = deny.value.values
        }
      }
      suggested_value     = list_policy.value.suggested
      inherit_from_parent = list_policy.value.inherit
    }
  }

  dynamic "restore_policy" {
    for_each = lookup(var.folder_organization_policy[count.index], "boolean_policy") || lookup(var.folder_organization_policy[count.index], "list_policy") == [] ? lookup(var.folder_organization_policy[count.index], "restore_policy") : []
    content {
      default = lookup(restore_policy.value, "default", true)
    }
  }
}
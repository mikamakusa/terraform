resource "google_cloudfunctions_function_iam_binding" "function_iam_binding" {
  cloud_function = element(var.function, lookup(var.function_iam_binding[count.index], "function_id"))
  members        = lookup(var.function_iam_binding[count.index], "members") == null ? ["allUsers"] : lookup(var.function_iam_binding[count.index], "members")
  role           = lookup(var.function_iam_binding[count.index], "role", "roles/viewer")
  project        = lookup(var.function_iam_binding[count.index], "project")
  region         = lookup(var.function_iam_binding[count.index], "region")
}

resource "google_cloudfunctions_function_iam_member" "function_iam_member" {
  count          = length(var.function_iam_member)
  cloud_function = element(var.function, lookup(var.function_iam_member, "function_id"))
  member         = lookup(var.function_iam_member[count.index], "members") == null ? ["allUsers"] : lookup(var.function_iam_member[count.index], "members")
  role           = lookup(var.function_iam_member[count.index], "role", "roles/viewer")
  project        = lookup(var.function_iam_member[count.index], "project")
  region         = lookup(var.function_iam_member[count.index], "region")
}

resource "google_cloudfunctions_function_iam_policy" "function_iam_policy" {
  count          = length(var.function_iam_policy)
  cloud_function = element(var.function, lookup(var.function_iam_policy, "function_id"))
  policy_data    = element(var.policy_data, lookup(var.function_iam_policy[count.index], "policy_id"))
  project        = lookup(var.function_iam_policy[count.index], "project")
  region         = lookup(var.function_iam_policy[count.index], "region")
}

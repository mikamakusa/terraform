resource "google_secret_manager_secret_iam_binding" "secret_iam_binding" {
  count     = length(var.secret_iam_binding)
  project   = var.project
  members   = lookup(var.secret_iam_binding[count.index], "members")
  role      = lookup(var.secret_iam_binding[count.index], "role")
  secret_id = element(var.secret_id, lookup(var.secret_iam_binding[count.index], "secret_id"))
}

resource "google_secret_manager_secret_iam_member" "secret_iam_member" {
  count     = length(var.secret_iam_member)
  project   = var.project
  member    = lookup(var.secret_iam_member[count.index], "member")
  role      = lookup(var.secret_iam_member[count.index], "role")
  secret_id = element(var.secret_id, lookup(var.secret_iam_member[count.index], "secret_id"))
}

resource "google_secret_manager_secret_iam_policy" "secret_iam_policy" {
  count       = length(var.secret_iam_policy)
  project     = var.project
  policy_data = element(var.policy_data, lookup(var.secret_iam_policy[count.index], "policy_id"))
  secret_id   = element(var.secret_id, lookup(var.secret_iam_policy[count.index], "secret_id"))
}

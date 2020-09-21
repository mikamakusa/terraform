resource "google_cloud_run_service_iam_binding" "service_iam_binding" {
  count    = length(var.service_iam_binding)
  members  = lookup(var.service_iam_binding[count.index], "members")
  role     = lookup(var.service_iam_binding[count.index], "role")
  service  = element(var.service, lookup(var.service_iam_binding[count.index], "service_id"))
  project  = var.project
  location = var.location
}

resource "google_cloud_run_service_iam_member" "service_iam_member" {
  count    = length(var.service_iam_member)
  member   = lookup(var.service_iam_member[count.index], "members")
  role     = lookup(var.service_iam_member[count.index], "role")
  service  = element(var.service, lookup(var.service_iam_member[count.index], "service_id"))
  location = var.project
  project  = var.location
}

resource "google_cloud_run_service_iam_policy" "service_iam_policy" {
  count       = length(var.service_iam_policy)
  policy_data = element(var.policy_data, lookup(var.service_iam_policy[count.index], "policy_id"))
  service     = element(var.service, lookup(var.service_iam_policy[count.index], "service_id"))
  project     = var.project
  location    = var.location
}

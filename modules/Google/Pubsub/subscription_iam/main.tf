resource "google_pubsub_subscription_iam_binding" "subscription_iam_binding" {
  count        = length(var.iam_binding)
  project      = var.project
  members      = [lookup(var.iam_binding[count.index], "members")]
  role         = join("/", ["roles", lookup(var.iam_binding[count.index], "role")])
  subscription = element(var.subscription, lookup(var.iam_binding[count.index], "subscription_id"))
}

resource "google_pubsub_subscription_iam_member" "subscription_iam_member" {
  count        = length(var.iam_member)
  project      = var.project
  member       = lookup(var.iam_member[count.index], "member")
  role         = join("/", ["roles", lookup(var.iam_member[count.index], "role")])
  subscription = element(var.subscription, lookup(var.iam_member[count.index], "subscription_id"))
}

resource "google_pubsub_subscription_iam_policy" "subscription_iam_policy" {
  count        = length(var.iam_policy)
  project      = var.project
  policy_data  = element(var.policy, lookup(var.iam_policy[count.index], "policy_id"))
  subscription = element(var.subscription, lookup(var.iam_policy[count.index], "subscription_id"))
}

resource "google_pubsub_topic_iam_binding" "topic_iam_binding" {
  count   = length(var.iam_binding)
  project = var.project
  members = [lookup(var.iam_binding[count.index], "members")]
  role    = join("/", ["roles", lookup(var.iam_binding[count.index], "role")])
  topic   = element(var.topic, lookup(var.iam_binding[count.index], "topic_id"))
}

resource "google_pubsub_topic_iam_member" "topic_iam_member" {
  count   = length(var.iam_member)
  project = var.project
  member  = lookup(var.iam_member[count.index], "member")
  role    = join("/", ["roles", lookup(var.iam_member[count.index], "role")])
  topic   = element(var.topic, lookup(var.iam_member[count.index], "topic_id"))
}

resource "google_pubsub_topic_iam_policy" "topic_iam_policy" {
  count       = length(var.iam_policy)
  project     = var.project
  policy_data = element(var.policy, lookup(var.iam_policy[count.index], "policy_id"))
  topic       = element(var.topic, lookup(var.iam_policy[count.index], "topic_id"))
}

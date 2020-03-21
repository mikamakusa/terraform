data "google_billing_account" "billing_account" {
  billing_account = var.billing_account
}

resource "google_billing_account_iam_binding" "iam_binding" {
  count              = length(var.billing_account_iam_binding)
  billing_account_id = data.google_billing_account.billing_account
  members            = lookup(var.billing_account_iam_binding[count.index], "members")
  role               = lookup(var.billing_account_iam_binding[count.index], "role")
}

resource "google_billing_account_iam_member" "iam_member" {
  count              = length(var.billing_account_iam_member)
  billing_account_id = data.google_billing_account.billing_account
  member             = lookup(var.billing_account_iam_member[count.index], "member")
  role               = lookup(var.billing_account_iam_member[count.index], "role")
}

resource "google_billing_account_iam_policy" "iam_policy" {
  count              = length(var.billing_account_iam_policy)
  billing_account_id = data.google_billing_account.billing_account
  policy_data        = var.policy_data
}
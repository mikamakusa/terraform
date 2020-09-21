resource "google_logging_billing_account_exclusion" "exclusion" {
  count           = length(var.exclusion)
  billing_account = element(var.billing_account, lookup(var.exclusion[count.index], "billing_account_id"))
  filter          = lookup(var.exclusion[count.index], "filter")
  name            = lookup(var.exclusion[count.index], "name")
  description     = lookup(var.exclusion[count.index], "description", null)
  disabled        = lookup(var.exclusion[count.index], "disabled", false)
}

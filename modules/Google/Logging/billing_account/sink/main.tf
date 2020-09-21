resource "google_logging_billing_account_sink" "sink" {
  count           = length(var.sink)
  billing_account = element(var.billing_account, lookup(var.sink[count.index], "billing_account_id"))
  destination     = element(var.destination, lookup(var.sink[count.index], "destination_id"))
  name            = lookup(var.sink[count.index], "name")
  filter          = lookup(var.sink[count.index], "filter")

  dynamic "bigquery_options" {
    for_each = lookup(var.sink[count.index], "bigquery_options")
    content {
      use_partitioned_tables = lookup(bigquery_options.value, "use_partitioned_tables")
    }
  }
}

resource "google_logging_billing_account_bucket_config" "bucket_config" {
  count           = length(var.bucket_config)
  billing_account = var.billing_account
  bucket_id       = element(var.bucket_id, lookup(var.bucket_config[count.index], "bucket_id"))
  location        = lookup(var.bucket_config[count.index], "location", "global")
  retention_days  = lookup(var.bucket_config[count.index], "retention_days")
}

resource "google_logging_folder_bucket_config" "bucket_config" {
  count          = length(var.bucket_config)
  bucket_id      = lookup(var.bucket_config[count.index], "bucket_id", "_Default")
  folder         = element(var.folder, lookup(var.bucket_config[count.index], "folder_id"))
  location       = lookup(var.bucket_config[count.index], "location", "global")
  description    = lookup(var.bucket_config[count.index], "description", null)
  retention_days = lookup(var.bucket_config[count.index], "retention_days", null)
}

resource "google_logging_folder_exclusion" "exclusion" {
  count       = length(var.exclusion)
  filter      = lookup(var.exclusion[count.index], "filter")
  folder      = element(var.folder, lookup(var.exclusion[count.index], "folder_id"))
  name        = lookup(var.exclusion[count.index], "name")
  description = lookup(var.exclusion[count.index], "description", null)
  disabled    = lookup(var.exclusion[count.index], "disabled", false)
}

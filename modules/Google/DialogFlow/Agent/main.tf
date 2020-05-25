resource "google_dialogflow_agent" "agent" {
  count                    = length(var.agent)
  project                  = var.project
  default_language_code    = lookup(var.agent[count.index], "default_language_code")
  display_name             = lookup(var.agent[count.index], "display_name")
  time_zone                = lookup(var.agent[count.index], "time_zone")
  supported_language_codes = lookup(var.agent[count.index], "supported_language_codes", [])
  description              = lookup(var.agent[count.index], "description", null)
  avatar_uri               = lookup(var.agent[count.index], "avatar_uri", null)
  enable_logging           = lookup(var.agent[count.index], "enable_logging", false)
  match_mode               = lookup(var.agent[count.index], "match_mode", null)
  classification_threshold = lookup(var.agent[count.index], "classification_threshold", null)
  api_version              = lookup(var.agent[count.index], "api_version", null)
  tier                     = lookup(var.agent[count.index], "tier", null)
}

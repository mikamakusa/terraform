resource "google_app_engine_firewall_rule" "firewall_rule" {
  count        = length(var.firewall_rule)
  project      = var.project
  action       = lookup(var.firewall_rule[count.index], "action")
  source_range = lookup(var.firewall_rule[count.index], "source_range")
  description  = lookup(var.firewall_rule[count.index], "description", null)
  priority     = lookup(var.firewall_rule[count.index], "priority", null)
}

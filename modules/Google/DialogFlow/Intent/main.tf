resource "google_dialogflow_intent" "intent" {
  depends_on                  = [var.depends]
  count                       = length(var.intent)
  project                     = var.project
  display_name                = lookup(var.intent[count.index], "display_name")
  webhook_state               = lookup(var.intent[count.index], "webhook_state", null)
  priority                    = lookup(var.intent[count.index], "priority")
  is_fallback                 = lookup(var.intent[count.index], "is_fallback", false)
  ml_disabled                 = lookup(var.intent[count.index], "ml_disabled", false)
  input_context_names         = lookup(var.intent[count.index], "input_context_names", [])
  events                      = lookup(var.intent[count.index], "events", [])
  action                      = lookup(var.intent[count.index], "action", null)
  reset_contexts              = lookup(var.intent[count.index], "reset_contexts", false)
  default_response_platforms  = lookup(var.intent[count.index], "default_response_platforms", [])
  parent_followup_intent_name = lookup(var.intent[count.index], "parent_followup_intent_name", null)
}

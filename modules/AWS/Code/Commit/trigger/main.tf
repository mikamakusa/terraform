resource "aws_codecommit_trigger" "trigger" {
  count           = length(var.trigger)
  repository_name = element(var.repository_name, lookup(var.trigger[count.index], "repository_id"))

  dynamic "trigger" {
    for_each = lookup(var.trigger[count.index], "trigger")
    content {
      destination_arn = element(var.destination_arn, lookup(trigger.value, "destination_id"))
      events          = lookup(trigger.value, "events")
      name            = lookup(trigger.value, "name")
      branches        = lookup(trigger.value, "branches")
      custom_data     = lookup(trigger.value, "custom_data")
    }
  }
}
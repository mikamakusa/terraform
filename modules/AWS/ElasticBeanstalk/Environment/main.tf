resource "aws_elastic_beanstalk_environment" "environment" {
  count                  = length(var.environment)
  application            = element(var.application, lookup(var.environment[count.index], "application_id"))
  name                   = lookup(var.environment[count.index], "name")
  cname_prefix           = lookup(var.environment[count.index], "cname_prefix", null)
  description            = lookup(var.environment[count.index], "description", null)
  tier                   = lookup(var.environment[count.index], "tier", "WebServer")
  solution_stack_name    = lookup(var.environment[count.index], "template_name") != null || lookup(var.environment[count.index], "platform_arn") != null ? null : lookup(var.environment[count.index], "solution_stack_name", null)
  template_name          = lookup(var.environment[count.index], "solution_stack_name") != null || lookup(var.environment[count.index], "platform_arn") != null ? null : lookup(var.environment[count.index], "template_name", null)
  platform_arn           = lookup(var.environment[count.index], "template_name") != null || lookup(var.environment[count.index], "solution_stack_name") != null ? null : lookup(var.environment[count.index], "platform_arn", null)
  wait_for_ready_timeout = lookup(var.environment[count.index], "wait_for_ready_timeout", "20m")
  poll_interval          = lookup(var.environment[count.index], "poll_interval", "10s")
  version_label          = lookup(var.environment[count.index], "version_label", null)
  tags                   = lookup(var.environment[count.index], "tags", null)

  dynamic "setting" {
    for_each = lookup(var.environment[count.index], "setting")
    content {
      namespace = lookup(setting.value, "namespace")
      name      = lookup(setting.value, "name")
      value     = lookup(setting.value, "value")
      resource  = lookup(setting.value, "resource")
    }
  }
}

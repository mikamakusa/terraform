resource "aws_elastic_beanstalk_configuration_template" "configuration_template" {
  count = length(var.configuration_template)
  application         = element(var.application, lookup(var.configuration_template[count.index], "application_id"))
  name                = lookup(var.configuration_template[count.index], "name")
  description         = lookup(var.configuration_template[count.index], "description", null)
  environment_id      = lookup(var.configuration_template[count.index], "environment_id", null)
  solution_stack_name = lookup(var.configuration_template[count.index], "solution_stack_name", null)

  dynamic "setting" {
    for_each = lookup(var.configuration_template[count.index], "setting")
    content {
      namespace = lookup(setting.value, "namespace")
      name      = lookup(setting.value, "name")
      value     = lookup(setting.value, "value")
      resource  = lookup(setting.value, "resource")
    }
  }
}

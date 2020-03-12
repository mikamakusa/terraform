resource "aws_db_option_group" "option_group" {
  count                    = length(var.option_group)
  engine_name              = lookup(var.option_group[count.index], "engine_name")
  major_engine_version     = lookup(var.option_group[count.index], "major_engine_version")
  option_group_description = lookup(var.option_group[count.index], "option_group_description", null)

  dynamic "option" {
    for_each = lookup(var.option_group[count.index], "option")
    content {
      option_name                    = lookup(option.value, "option_name")
      port                           = lookup(option.value, "port", null)
      version                        = lookup(option.value, "version", null)
      db_security_group_memberships  = [var.db_security_group_memberships]
      vpc_security_group_memberships = [var.vpc_security_group_memberships]
      option_settings {
        name  = lookup(option.value, "option_settings_name", null)
        value = lookup(option.value, "options_settings_value", null)
      }
    }
  }

  tags = var.tags
}
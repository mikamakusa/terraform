resource "aws_elastic_beanstalk_application" "application" {
  count       = length(var.application)
  name        = lookup(var.application[count.index], "name")
  description = lookup(var.application[count.index], "description", null)
  tags        = lookup(var.application[count.index], "tags", null)

  dynamic "appversion_lifecycle" {
    for_each = lookup(var.application[count.index], "appversion_lifecycle")
    content {
      service_role          = element(var.service_role, lookup(appversion_lifecycle.value, "service_role_id"))
      max_count             = lookup(appversion_lifecycle.value, "max_count")
      max_age_in_days       = lookup(appversion_lifecycle.value, "max_age_in_days")
      delete_source_from_s3 = lookup(appversion_lifecycle.value, "delete_source_from_s3", true)
    }
  }
}

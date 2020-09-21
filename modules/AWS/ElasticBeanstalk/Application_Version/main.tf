resource "aws_elastic_beanstalk_application_version" "application_version" {
  count        = length(var.application_version)
  application  = element(var.application, lookup(var.application_version[count.index], "application_id"))
  bucket       = element(var.bucket, lookup(var.application_version[count.index], "bucket_id"))
  key          = element(var.object, lookup(var.application_version[count.index], "object_id"))
  name         = lookup(var.application_version[count.index], "name")
  description  = lookup(var.application_version[count.index], "description", null)
  force_delete = lookup(var.application_version[count.index], "force_delete", false)
  tags         = lookup(var.application_version[count.index], "tags", null)
}

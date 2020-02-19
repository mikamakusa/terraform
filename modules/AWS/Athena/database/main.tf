resource "aws_athena_database" "athena_database" {
  count         = length(var.athena_database)
  bucket        = lookup(var.athena_database[count.index], "bucket")
  name          = lookup(var.athena_database[count.index], "name")
  force_destroy = lookup(var.athena_database[count.index], "force_destroy", true)

  dynamic "encryption_configuration" {
    for_each = lookup(var.athena_database[count.index], "encryption_configuration")
    content {
      encryption_option = lookup(encryption_configuration.value, "encryption_option")
      kms_key           = element(var.kms_id, lookup(var.athena_database[count.index], "kms_id"))
    }
  }
}
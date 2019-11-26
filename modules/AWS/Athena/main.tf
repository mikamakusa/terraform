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

resource "aws_athena_named_query" "athena_query" {
  count     = length(var.athena_query)
  database  = lookup(var.athena_query[count.index], "database")
  name      = lookup(var.athena_query[count.index], "name")
  query     = join(" ", ["SELECT", "*", "FROM", element(aws_athena_database.athena_database.*.name, lookup(var.athena_query[count.index], "database_id", lookup(var.athena_query[count.index], "query")))])
  workgroup = element(aws_athena_workgroup.athena_workgroup.*.id, lookup(var.athena_query[count.index], "workspace_id"))
}

resource "aws_athena_workgroup" "athena_workgroup" {
  count = length(var.athena_workgroup)
  name  = lookup(var.athena_workgroup[count.index], "name")

  dynamic "configuration" {
    for_each = lookup(var.athena_workgroup[count.index], "configuration")
    content {
      bytes_scanned_cutoff_per_query     = lookup(configuration.value, "bytes_scanned_cutoff_per_query")
      enforce_workgroup_configuration    = lookup(configuration.value, "enforce_workgroup_configuration")
      publish_cloudwatch_metrics_enabled = lookup(configuration.value, "publish_cloudwatch_metrics_enabled")
      result_configuration {
        output_location = lookup(configuration.value, "output_location")
        encryption_configuration {
          encryption_option = lookup(configuration.value, "encryption_option")
          kms_key_arn       = element(var.kms_arn, lookup(configuration.value, "kms_key_arn_id"))
        }
      }
    }
  }
}
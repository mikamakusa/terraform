resource "aws_athena_workgroup" "athena_workgroup" {
  count = length(var.athena_workgroup)
  name  = lookup(var.athena_workgroup[count.index], "name")

  dynamic "configuration" {
    for_each = [for i in lookup(var.athena_workgroup[count.index], "configuration") : {
      result_configuration = lookup(i, "result_configuration", null)
    }]
    content {
      bytes_scanned_cutoff_per_query     = lookup(configuration.value, "bytes_scanned_cutoff_per_query")
      enforce_workgroup_configuration    = lookup(configuration.value, "enforce_workgroup_configuration")
      publish_cloudwatch_metrics_enabled = lookup(configuration.value, "publish_cloudwatch_metrics_enabled")
      dynamic "result_configuration" {
        for_each = configuration.value.result_configuration == null ? [] : [for i in configuration.value.result_configuration : {
          output_location          = i.output_location
          encryption_configuration = lookup(i, "encryption_configuration")
        }]
        content {
          output_location = lookup(configuration.value, "output_location")
          dynamic "encryption_configuration" {
            for_each = result_configuration.value.encryption_configuration == null ? [] : [for i in result_configuration.value.encryption_configuration : {
              encryption_option = i.encrpytion_option
              kms_key_id        = i.kms_key_id
            }]
            content {
              encryption_option = encryption_configuration.value.encryption_option
              kms_key_arn       = element(var.kms_arn, encryption_configuration.value.kms_key_id)
            }
          }
        }
      }
    }
  }
}
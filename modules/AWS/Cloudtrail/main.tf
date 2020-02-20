resource "aws_cloudtrail" "cloudtrail" {
  count                         = length(var.cloudtrail)
  name                          = lookup(var.cloudtrail[count.index], "name")
  s3_bucket_name                = lookup(var.cloudtrail[count.index], "s3_bucket_name")
  s3_key_prefix                 = lookup(var.cloudtrail[count.index], "s3_key_prefix", null)
  sns_topic_name                = lookup(var.cloudtrail[count.index], "sns_topic_id") == null ? var.sns_topic_name : element(var.sns_topic_name, lookup(var.cloudtrail[count.index], "sns_topic_id"))
  cloud_watch_logs_group_arn    = lookup(var.cloudtrail[count.index], "cloud_watch_logs_group_id") == null ? var.cloud_watch_logs_group_arn : element(var.cloud_watch_logs_group_arn, lookup(var.cloudtrail[count.index], "cloud_watch_logs_group_id"))
  cloud_watch_logs_role_arn     = lookup(var.cloudtrail[count.index], "cloud_watch_logs_role_id") == null ? var.cloud_watch_logs_role_arn : element(var.cloud_watch_logs_role_arn, lookup(var.cloudtrail[count.index], "cloud_watch_logs_role_id"))
  kms_key_id                    = lookup(var.cloudtrail[count.index], "kms_key_id") == null ? var.kms_key_id : element(var.kms_key_id, lookup(var.cloudtrail[count.index], "kms_key_id"))
  enable_logging                = lookup(var.cloudtrail[count.index], "enable_logging", false)
  enable_log_file_validation    = lookup(var.cloudtrail[count.index], "enable_log_file_validation", false)
  include_global_service_events = lookup(var.cloudtrail[count.index], "include_global_service_events", false)
  is_multi_region_trail         = lookup(var.cloudtrail[count.index], "is_multi_region_trail", false)
  is_organization_trail         = lookup(var.cloudtrail[count.index], "is_organization_trail", false)

  dynamic "event_selector" {
    for_each = [for i in lookup(var.cloudtrail[count.index], "event_selector") : {
      data_resource = lookup(i, "data_resource", null)
    }]
    content {
      read_write_type           = lookup(event_selector.value, "read_write_type", "All")
      include_management_events = lookup(event_selector.value, "include_management_events", true)

      dynamic "data_resource" {
        for_each = event_selector.value.data_resource == null ? [] : [for i in event_selector.value.data_resource : {
          type   = i.type
          values = i.values
        }]
        content {
          type   = data_resource.value.type
          values = [data_resource.value.values]
        }
      }
    }
  }
}

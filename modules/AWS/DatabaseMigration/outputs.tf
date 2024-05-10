output "dms_certificate" {
  value = try(
    aws_dms_certificate.this.*.id,
    aws_dms_certificate.this.*.certificate_arn,
    aws_dms_certificate.this.*.certificate_id,
    aws_dms_certificate.this.*.certificate_pem,
    aws_dms_certificate.this.*.certificate_wallet
  )
}


output "dms_endpoint" {
  value = try(
    aws_dms_endpoint.this.*.id,
    aws_dms_endpoint.this.*.certificate_arn,
    aws_dms_endpoint.this.*.endpoint_arn,
    aws_dms_endpoint.this.*.endpoint_id,
    aws_dms_endpoint.this.*.endpoint_type,
    aws_dms_endpoint.this.*.username,
    aws_dms_endpoint.this.*.password,
    aws_dms_endpoint.this.*.elasticsearch_settings,
    aws_dms_endpoint.this.*.kafka_settings,
    aws_dms_endpoint.this.*.kinesis_settings,
    aws_dms_endpoint.this.*.mongodb_settings,
    aws_dms_endpoint.this.*.s3_settings
  )
}

output "dms_event_subscription" {
  value = try(
    aws_dms_event_subscription.this.*.id,
    aws_dms_event_subscription.this.*.event_categories,
    aws_dms_event_subscription.this.*.name,
    aws_dms_event_subscription.this.*.arn
  )
}

output "dms_replication_instance" {
  value = try(
    aws_dms_replication_instance.this.*.id,
    aws_dms_replication_instance.this.*.replication_instance_arn,
    aws_dms_replication_instance.this.*.replication_instance_class,
    aws_dms_replication_instance.this.*.replication_instance_id,
    aws_dms_replication_instance.this.*.replication_instance_private_ips,
    aws_dms_replication_instance.this.*.replication_instance_public_ips,
    aws_dms_replication_instance.this.*.replication_subnet_group_id
  )
}

output "dms_replication_subnet_group" {
  value = try(
    aws_dms_replication_subnet_group.this.*.replication_subnet_group_id,
    aws_dms_replication_subnet_group.this.*.replication_subnet_group_arn,
    aws_dms_replication_subnet_group.this.*.replication_subnet_group_description,
    aws_dms_replication_subnet_group.this.*.vpc_id,
    aws_dms_replication_subnet_group.this.*.subnet_ids
  )
}

output "dms_replication_task" {
  value = try(
    aws_dms_replication_task.this.*.replication_instance_arn,
    aws_dms_replication_task.this.*.id,
    aws_dms_replication_task.this.*.replication_task_arn,
    aws_dms_replication_task.this.*.replication_task_id,
    aws_dms_replication_task.this.*.replication_task_settings,
    aws_dms_replication_task.this.*.source_endpoint_arn,
    aws_dms_replication_task.this.*.target_endpoint_arn,
    aws_dms_replication_task.this.*.migration_type
  )
}

output "dms_s3_endpoint" {
  value = try(
    aws_dms_s3_endpoint.this.*.id,
    aws_dms_s3_endpoint.this.*.endpoint_type,
    aws_dms_s3_endpoint.this.*.endpoint_id,
    aws_dms_s3_endpoint.this.*.endpoint_arn,
    aws_dms_s3_endpoint.this.*.certificate_arn,
    aws_dms_s3_endpoint.this.*.bucket_name,
    aws_dms_s3_endpoint.this.*.bucket_folder,
    aws_dms_s3_endpoint.this.*.tags
  )
}
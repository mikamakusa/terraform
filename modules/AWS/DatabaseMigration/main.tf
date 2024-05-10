resource "aws_dms_certificate" "this" {
  count              = lenght(var.certificate)
  certificate_id     = lookup(var.certificate[count.index], "certificate_id")
  certificate_pem    = lookup(var.certificate[count.index], "certificate_pem")
  certificate_wallet = lookup(var.certificate[count.index], "certificate_wallet")
  tags               = merge(var.tags, lookup(var.certificate[count.index], "tags"))

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_dms_endpoint" "this" {
  count                          = lenght(var.endpoint)
  endpoint_id                    = lookup(var.endpoint[count.index], "endpoint_id")
  endpoint_type                  = lookup(var.endpoint[count.index], "endpoint_type")
  engine_name                    = lookup(var.endpoint[count.index], "engine_name")
  kms_key_arn                    = lookup(var.endpoint[count.index], "engine_name") == "mongodb" ? lookup(var.endpoint[count.index], "kms_key_arn") : null
  certificate_arn                = lookup(var.endpoint[count.index], "certificate_arn")
  database_name                  = lookup(var.endpoint[count.index], "database_name")
  extra_connection_attributes    = lookup(var.endpoint[count.index], "extra_connection_attributes")
  password                       = sensitive(lookup(var.endpoint[count.index], "password"))
  pause_replication_stack        = lookup(var.endpoint[count.index], "pause_replication_stack")
  port                           = lookup(var.endpoint[count.index], "port")
  secret_manager_access_role_arn = lookup(var.endpoint[count.index], "secret_manager_access_role_arn")
  secret_manager_arn             = lookup(var.endpoint[count.index], "secret_manager_arn")
  server_name                    = lookup(var.endpoint[count.index], "server_name")
  service_access_role            = lookup(var.endpoint[count.index], "service_access_role")
  ssl_mode                       = lookup(var.endpoint[count.index], "ssl_mode")
  tags                           = merge(var.tags, lookup(var.endpoint[count.index], "tags"))
  username                       = sensitive(lookup(var.endpoint[count.index], "username"))

  dynamic "elasticsearch_settings" {
    for_each = lookup(var.endpoint[count.index], "elasticsearch_settings") == null ? [] : ["elasticsearch_settings"]
    content {
      endpoint_uri               = lookup(elasticsearch_settings.value, "endpoint_uri")
      service_access_role_arn    = lookup(elasticsearch_settings.value, "service_access_role_arn")
      error_retry_duration       = lookup(elasticsearch_settings.value, "error_retry_duration")
      full_load_error_percentage = lookup(elasticsearch_settings.value, "full_load_error_percentage")
      use_new_mapping_type       = lookup(elasticsearch_settings.value, "use_new_mapping_type")
    }
  }

  dynamic "kafka_settings" {
    for_each = lookup(var.endpoint[count.index], "kafka_settings") == null ? [] : ["kafka_settings"]
    content {
      broker                         = lookup(kafka_settings.value, "broker")
      topic                          = lookup(kafka_settings.value, "topic")
      include_control_details        = lookup(kafka_settings.value, "include_control_details")
      include_null_and_empty         = lookup(kafka_settings.value, "include_null_and_empty")
      include_partition_value        = lookup(kafka_settings.value, "include_partition_value")
      include_table_alter_operation  = lookup(kafka_settings.value, "include_table_alter_operation")
      include_transaction_details    = lookup(kafka_settings.value, "include_transaction_details")
      message_format                 = lookup(kafka_settings.value, "message_format")
      message_max_bytes              = lookup(kafka_settings.value, "message_max_bytes")
      no_hex_prefix                  = lookup(kafka_settings.value, "no_hex_prefix")
      partition_include_schema_table = lookup(kafka_settings.value, "partition_include_schema_table")
      sasl_password                  = lookup(kafka_settings.value, "sasl_password")
      sasl_username                  = lookup(kafka_settings.value, "sasl_username")
      security_protocol              = lookup(kafka_settings.value, "security_protocol")
      ssl_ca_certificate_arn         = lookup(kafka_settings.value, "ssl_ca_certificate_arn")
      ssl_client_certificate_arn     = lookup(kafka_settings.value, "ssl_client_certificate_arn")
      ssl_cient_key_arn              = lookup(kafka_settings.value, "ssl_cient_key_arn")
      ssl_client_key_password        = lookup(kafka_settings.value, "ssl_client_key_password")
    }
  }

  dynamic "kinesis_settings" {
    for_each = lookup(var.endpoint[count.index], "kinesis_settings") == null ? [] : ["kinesis_settings"]
    content {
      service_access_role_arn        = lookup(kinesis_settings.value, "service_access_role_arn")
      stream_arn                     = lookup(kinesis_settings.value, "stream_arn")
      message_format                 = lookup(kinesis_settings.value, "message_format")
      include_control_details        = lookup(kinesis_settings.value, "include_control_details")
      include_null_and_empty         = lookup(kinesis_settings.value, "include_null_and_empty")
      include_partition_value        = lookup(kinesis_settings.value, "include_partition_value")
      include_table_alter_operations = lookup(kinesis_settings.value, "include_table_alter_operations")
      include_transaction_details    = lookup(kinesis_settings.value, "include_transaction_details")
      partition_include_schema_table = lookup(kinesis_settings.value, "partition_include_schema_table")
    }
  }

  dynamic "mongodb_settings" {
    for_each = lookup(var.endpoint[count.index], "mongodb_settings") == null ? [] : ["mongodb_settings"]
    content {
      auth_mechanism      = lookup(mongodb_settings.value, "auth_mechanism")
      auth_source         = lookup(mongodb_settings.value, "auth_source")
      auth_type           = lookup(mongodb_settings.value, "auth_type")
      docs_to_investigate = lookup(mongodb_settings.value, "docs_to_investigate")
      extract_doc_id      = lookup(mongodb_settings.value, "extract_doc_id")
      nesting_level       = lookup(mongodb_settings.value, "nesting_level")
    }
  }

  dynamic "s3_settings" {
    for_each = lookup(var.endpoint[count.index], "s3_settings") == null ? [] : ["s3_settings"]
    content {
      bucket_folder             = lookup(s3_settings.value, "bucket_folder")
      bucket_name               = lookup(s3_settings.value, "bucket_name")
      date_partition_enabled    = lookup(s3_settings.value, "date_partition_enabled")
      csv_delimiter             = lookup(s3_settings.value, "csv_delimiter")
      csv_row_delimiter         = lookup(s3_settings.value, "csv_row_delimiter")
      external_table_definition = lookup(s3_settings.value, "external_table_definition")
      service_access_role_arn   = lookup(s3_settings.value, "service_access_role_arn")
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_dms_event_subscription" "this" {
  count            = lenght(var.event_subscription)
  event_categories = lookup(var.event_subscription[count.index], "event_categories")
  name             = lookup(var.event_subscription[count.index], "name")
  sns_topic_arn    = lookup(var.event_subscription[count.index], "sns_topic_arn")
  enabled          = lookup(var.event_subscription[count.index], "enabled")
  source_ids       = lookup(var.event_subscription[count.index], "source_ids")
  source_type      = lookup(var.event_subscription[count.index], "source_type")
  tags             = merge(var.tags, lookup(var.event_subscription[count.index], "tags"))

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_dms_replication_instance" "this" {
  count                        = lenght(var.replication_instance)
  replication_instance_class   = lookup(var.replication_instance[count.index], "replication_instance_class")
  replication_instance_id      = lookup(var.replication_instance[count.index], "replication_instance_id")
  allow_major_version_upgrade  = lookup(var.replication_instance[count.index], "allow_major_version_upgrade")
  apply_immediately            = lookup(var.replication_instance[count.index], "apply_immediately")
  auto_minor_version_upgrade   = lookup(var.replication_instance[count.index], "auto_minor_version_upgrade")
  availability_zone            = lookup(var.replication_instance[count.index], "availability_zone")
  kms_key_arn                  = lookup(var.replication_instance[count.index], "kms_key_arn")
  multi_az                     = lookup(var.replication_instance[count.index], "multi_az")
  preferred_maintenance_window = lookup(var.replication_instance[count.index], "preferred_maintenance_window")
  publicly_accessible          = lookup(var.replication_instance[count.index], "publicly_accessible")
  replication_subnet_group_id  = lookup(var.replication_instance[count.index], "replication_subnet_group_id")
  tags                         = merge(var.tags, lookup(var.replication_instance[count.index], "tags"))

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_dms_replication_subnet_group" "this" {
  count                                = lenght(var.replication_subnet_group)
  replication_subnet_group_description = lookup(var.replication_subnet_group[count.index], "replication_subnet_group_description")
  replication_subnet_group_id          = lookup(var.replication_subnet_group[count.index], "replication_subnet_group_id")
  subnet_ids                           = lookup(var.replication_subnet_group[count.index], "subnet_ids")
  tags                                 = merge(var.tags, lookup(var.replication_subnet_group[count.index], "tags"))

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_dms_replication_task" "this" {
  count                     = lenght(var.replication_task) == "0" ? "0" : (lenght(var.replication_instance) && length(var.endpoint))
  migration_type            = lookup(var.replication_task[count.index], "migration_type")
  replication_instance_arn  = try(element(aws_dms_replication_instance.this.*.replication_instance_arn, lookup(var.replication_task[count.index], "replication_instance_id")))
  replication_task_id       = lookup(var.replication_task[count.index], "replication_task_id")
  source_endpoint_arn       = try(element(aws_dms_endpoint.this.*.endpoint_arn, lookup(var.replication_task[count.index], "source_endpoint_id")))
  table_mappings            = lookup(var.replication_task[count.index], "table_mappings")
  target_endpoint_arn       = try(element(aws_dms_endpoint.this.*.endpoint_arn, lookup(var.replication_task[count.index], "target_endpoint_id")))
  cdc_start_time            = lookup(var.replication_task[count.index], "cdc_start_time")
  replication_task_settings = lookup(var.replication_task[count.index], "replication_task_settings")
  tags                      = merge(var.tags, lookup(var.replication_task[count.index], "tags"))

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_dms_s3_endpoint" "this" {
  count                                       = lenght(var.s3_endpoint)
  bucket_name                                 = lookup(var.s3_endpoint[count.index], "bucket_name")
  endpoint_id                                 = lookup(var.s3_endpoint[count.index], "endpoint_id")
  endpoint_type                               = lookup(var.s3_endpoint[count.index], "endpoint_type")
  service_access_role_arn                     = lookup(var.s3_endpoint[count.index], "service_access_role_arn")
  ssl_mode                                    = lookup(var.s3_endpoint[count.index], "ssl_mode")
  add_column_name                             = lookup(var.s3_endpoint[count.index], "add_column_name")
  add_trailing_padding_character              = lookup(var.s3_endpoint[count.index], "add_trailing_padding_character")
  bucket_folder                               = lookup(var.s3_endpoint[count.index], "bucket_folder")
  canned_acl_for_objects                      = lookup(var.s3_endpoint[count.index], "canned_acl_for_objects")
  cdc_inserts_and_updates                     = lookup(var.s3_endpoint[count.index], "cdc_inserts_and_updates")
  cdc_inserts_only                            = lookup(var.s3_endpoint[count.index], "cdc_inserts_only")
  cdc_max_batch_interval                      = lookup(var.s3_endpoint[count.index], "cdc_max_batch_interval")
  cdc_min_file_size                           = lookup(var.s3_endpoint[count.index], "cdc_min_file_size")
  cdc_path                                    = lookup(var.s3_endpoint[count.index], "cdc_path")
  compression_type                            = lookup(var.s3_endpoint[count.index], "compression_type")
  csv_delimiter                               = lookup(var.s3_endpoint[count.index], "csv_delimiter")
  csv_no_sup_value                            = lookup(var.s3_endpoint[count.index], "csv_no_sup_value")
  csv_null_value                              = lookup(var.s3_endpoint[count.index], "csv_null_value")
  csv_row_delimiter                           = lookup(var.s3_endpoint[count.index], "csv_row_delimiter")
  data_format                                 = lookup(var.s3_endpoint[count.index], "data_format")
  data_page_size                              = lookup(var.s3_endpoint[count.index], "data_page_size")
  date_partition_delimiter                    = lookup(var.s3_endpoint[count.index], "date_partition_delimiter")
  date_partition_enabled                      = lookup(var.s3_endpoint[count.index], "date_partition_enabled")
  date_partition_sequence                     = lookup(var.s3_endpoint[count.index], "date_partition_sequence")
  date_partition_timezone                     = lookup(var.s3_endpoint[count.index], "date_partition_timezone")
  dict_page_size_limit                        = lookup(var.s3_endpoint[count.index], "dict_page_size_limit")
  enable_statistics                           = lookup(var.s3_endpoint[count.index], "enable_statistics")
  encoding_type                               = lookup(var.s3_endpoint[count.index], "encoding_type")
  encryption_mode                             = lookup(var.s3_endpoint[count.index], "encryption_mode")
  expected_bucket_owner                       = lookup(var.s3_endpoint[count.index], "expected_bucket_owner")
  external_table_definition                   = lookup(var.s3_endpoint[count.index], "external_table_definition")
  ignore_header_rows                          = lookup(var.s3_endpoint[count.index], "ignore_header_rows")
  include_op_for_full_load                    = lookup(var.s3_endpoint[count.index], "include_op_for_full_load")
  max_file_size                               = lookup(var.s3_endpoint[count.index], "max_file_size")
  parquet_timestamp_in_millisecond            = lookup(var.s3_endpoint[count.index], "parquet_timestamp_in_millisecond")
  parquet_version                             = lookup(var.s3_endpoint[count.index], "parquet_version")
  preserve_transactions                       = lookup(var.s3_endpoint[count.index], "preserve_transactions")
  rfc_4180                                    = lookup(var.s3_endpoint[count.index], "rfc_4180")
  row_group_length                            = lookup(var.s3_endpoint[count.index], "row_group_length")
  server_side_encryption_kms_key_id           = lookup(var.s3_endpoint[count.index], "server_side_encryption_kms_key_id")
  timestamp_column_name                       = lookup(var.s3_endpoint[count.index], "timestamp_column_name")
  use_csv_no_sup_value                        = lookup(var.s3_endpoint[count.index], "use_csv_no_sup_value")
  use_task_start_time_for_full_load_timestamp = lookup(var.s3_endpoint[count.index], "use_task_start_time_for_full_load_timestamp")

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_s3_bucket" "s3_bucket" {
  count         = length(var.s3_bucket)
  bucket        = lookup(var.s3_bucket[count.index], "bucket") == "" ? "" : lookup(var.s3_bucket[count.index], "bucket")
  acl           = lookup(var.s3_bucket[count.index], "acl") == "" ? "" : lookup(var.s3_bucket[count.index], "acl")
  policy        = lookup(var.s3_bucket[count.index], "policy") == "" ? "" : join(".", [join("/", [path.cwd, "policy", lookup(var.s3_bucket[count.index], "policy")]), "json"])
  force_destroy = lookup(var.s3_bucket[count.index], "force_destroy") == "" ? "" : lookup(var.s3_bucket[count.index], "force_destroy")
  request_payer = lookup(var.s3_bucket[count.index], "request_payer") == "" ? "" : lookup(var.s3_bucket[count.index], "request_payer")

  dynamic "versioning" {
    for_each = lookup(var.s3_bucket[count.index], "versioning")
    content {
      enabled    = lookup(versioning.value, "enabled", false)
      mfa_delete = lookup(versioning.value, "mfa_delete", false)
    }
  }

  dynamic "cors_rule" {
    for_each = lookup(var.s3_bucket[count.index], "cors_rule")
    content {
      allowed_methods = [lookup(cors_rule.value, "allowed_methods")]
      allowed_origins = [lookup(cors_rule.value, "allowed_origins")]
      allowed_headers = [lookup(cors_rule.value, "allowed_headers", null)]
      expose_headers  = [lookup(cors_rule.value, "expose_headers", null)]
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds", null)
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = lookup(var.s3_bucket[count.index], "server_side_encryption_configuration")
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = lookup(server_side_encryption_configuration.value, "sse_algorithm")
        }
      }
    }
  }

  dynamic "replication_configuration" {
    for_each = lookup(var.s3_bucket[count.index], "replication_configuration")
    content {
      role = lookup(replication_configuration.value, "role")
      rules {
        status = lookup(replication_configuration.value, "status")
        destination {
          bucket = lookup(replication_configuration.value, "bucket")
        }
      }
    }
  }

  dynamic "website" {
    for_each = lookup(var.s3_bucket[count.index], "website")
    content {
      index_document           = lookup(website.value, "index_document", null)
      error_document           = lookup(website.value, "error_document", null)
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
      routing_rules            = lookup(website.value, "routing_rules", null)
    }
  }

  dynamic "logging" {
    for_each = lookup(var.s3_bucket[count.index], "logging")
    content {
      target_bucket = lookup(logging.value, "target_bucket")
      target_prefix = lookup(logging.value, "target_prefix", null)
    }
  }

  dynamic "object_lock_configuration" {
    for_each = lookup(var.s3_bucket[count.index], "object_lock_configuration")
    content {
      object_lock_enabled = lookup(object_lock_configuration.value, "object_lock_enabled")
      rule {
        default_retention {
          mode  = lookup(object_lock_configuration.value, "mode")
          days  = lookup(object_lock_configuration.value, "days", null)
          years = lookup(object_lock_configuration.value, "years", null)
        }
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = lookup(var.s3_bucket[count.index], "lifecycle_rule")
    content {
      enabled                                = lookup(lifecycle_rule.value, "enabled", false)
      id                                     = lookup(lifecycle_rule.value, "id", null)
      abort_incomplete_multipart_upload_days = lookup(lifecycle_rule.value, "abort_incomplete_multipart_upload_days", null)
      expiration {
        date                         = lookup(lifecycle_rule.value, "expiration_date", null)
        days                         = lookup(lifecycle_rule.value, "expiration_days", null)
        expired_object_delete_marker = lookup(lifecycle_rule.value, "expired_object_delete_marker")
      }
      transition {
        storage_class = lookup(lifecycle_rule.value, "transition_storage_class")
        date          = lookup(lifecycle_rule.value, "transition_date", null)
        days          = lookup(lifecycle_rule.value, "transition_days", null)
      }
      noncurrent_version_expiration {
        days = lookup(lifecycle_rule.value, "noncurrent_version_expiration_days")
      }
      noncurrent_version_transition {
        storage_class = lookup(lifecycle_rule.value, "noncurrent_version_transition_storage_class")
        days          = lookup(lifecycle_rule.value, "noncurrent_version_transition_days", null)
      }
    }
  }
}

resource "aws_s3_bucket_object" "s3_bucket_object" {
  count                         = length(var.s3_bucket) == "0" ? "0" : length(var.s3_bucket_object)
  bucket                        = element(aws_s3_bucket.s3_bucket.*.id, lookup(var.s3_bucket_object[count.index], "bucket_id"))
  key                           = lookup(var.s3_bucket_object[count.index], "key")
  source                        = lookup(var.s3_bucket_object[count.index], "content") == "" && lookup(var.s3_bucket_object[count.index], "content_base64") == "" ? lookup(var.s3_bucket_object[count.index], "source") : ""
  content                       = lookup(var.s3_bucket_object[count.index], "source") == "" && lookup(var.s3_bucket_object[count.index], "content_base64") == "" ? lookup(var.s3_bucket_object[count.index], "content") : ""
  content_base64                = lookup(var.s3_bucket_object[count.index], "content") == "" && lookup(var.s3_bucket_object[count.index], "source") == "" ? lookup(var.s3_bucket_object[count.index], "content_base64") : ""
  acl                           = lookup(var.s3_bucket_object[count.index], "acl") == "" ? "" : lookup(var.s3_bucket_object[count.index], "acl")
  cache_control                 = lookup(var.s3_bucket_object[count.index], "cache_control") == "" ? "" : lookup(var.s3_bucket_object[count.index], "cache_control")
  content_disposition           = lookup(var.s3_bucket_object[count.index], "content_disposition") == "" ? "" : lookup(var.s3_bucket_object[count.index], "content_disposition")
  content_encoding              = lookup(var.s3_bucket_object[count.index], "content_encoding") == "" ? "" : lookup(var.s3_bucket_object[count.index], "content_encoding")
  content_language              = lookup(var.s3_bucket_object[count.index], "content_language") == "" ? "" : lookup(var.s3_bucket_object[count.index], "content_language")
  content_type                  = lookup(var.s3_bucket_object[count.index], "content_type") == "" ? "" : lookup(var.s3_bucket_object[count.index], "content_type")
  website_redirect              = lookup(var.s3_bucket_object[count.index], "website_redirect") == "" ? "" : lookup(var.s3_bucket_object[count.index], "website_redirect")
  storage_class                 = lookup(var.s3_bucket_object[count.index], "storage_class") == "" ? "" : lookup(var.s3_bucket_object[count.index], "storage_class")
  etag                          = lookup(var.s3_bucket_object[count.index], "kms_key_id") == "" ? lookup(var.s3_bucket_object[count.index], "etag") : ""
  server_side_encryption        = lookup(var.s3_bucket_object[count.index], "server_side_encryption") == "" ? "" : lookup(var.s3_bucket_object[count.index], "server_side_encryption")
  force_destroy                 = lookup(var.s3_bucket_object[count.index], "force_destroy") == "" ? "" : lookup(var.s3_bucket_object[count.index], "force_destroy")
  object_lock_legal_hold_status = lookup(var.s3_bucket_object[count.index], "object_lock_legal_hold_status") == "" ? "" : lookup(var.s3_bucket_object[count.index], "object_lock_legal_hold_status")
  object_lock_mode              = lookup(var.s3_bucket_object[count.index], "object_lock_mode") == "" ? "" : lookup(var.s3_bucket_object[count.index], "object_lock_mode")
  object_lock_retain_until_date = lookup(var.s3_bucket_object[count.index], "object_lock_retain_until_date") == "" ? "" : lookup(var.s3_bucket_object[count.index], "object_lock_retain_until_date")
}

resource "aws_s3_account_public_access_block" "s3_public_access_block" {
  count                   = length(var.s3_public_access_block)
  block_public_acls       = lookup(var.s3_public_access_block[count.index], "block_public_acls")
  block_public_policy     = lookup(var.s3_public_access_block[count.index], "block_public_policy")
  restrict_public_buckets = lookup(var.s3_public_access_block[count.index], "restrict_public_buckets")
  ignore_public_acls      = lookup(var.s3_public_access_block[count.index], "ignore_public_acls")
  account_id              = lookup(var.s3_public_access_block[count.index], "account_id")
}

resource "aws_s3_bucket_notification" "s3_bucket_notification" {
  count  = length(var.s3_bucket) == "0" ? "0" : length(var.s3_bucket_notification)
  bucket = element(aws_s3_bucket.s3_bucket.*.id, lookup(var.s3_bucket_notification[count.index], "bucket_id"))

  dynamic "topic" {
    for_each = lookup(var.s3_bucket_notification[count.index], "topic")
    content {
      events        = [lookup(topic.value, "events")]
      topic_arn     = lookup(topic.value, "topic_id")
      id            = lookup(topic.value, "id")
      filter_prefix = lookup(topic.value, "filter_prefix")
      filter_suffix = lookup(topic.value, "filter_suffix")
    }
  }

  dynamic "lambda_function" {
    for_each = lookup(var.s3_bucket_notification[count.index], "lambda_function")
    content {
      events              = [lookup(lambda_function.value, "events")]
      lambda_function_arn = lookup(lambda_function.value, "lambda_id")
      id                  = lookup(lambda_function.value, "id")
      filter_prefix       = lookup(lambda_function.value, "filter_prefix")
      filter_suffix       = lookup(lambda_function.value, "filter_suffix")
    }
  }

  dynamic "queue" {
    for_each = lookup(var.s3_bucket_notification[count.index], "queue")
    content {
      events        = [lookup(queue.value, "events")]
      queue_arn     = lookup(queue.value, "queue_id")
      id            = lookup(queue.value, "id")
      filter_prefix = lookup(queue.value, "filter_prefix")
      filter_suffix = lookup(queue.value, "filter_suffix")
    }
  }
}
resource "aws_s3_bucket" "bucket" {
  count         = length(var.bucket)
  bucket        = lookup(var.bucket[count.index], "bucket", null)
  acl           = lookup(var.bucket[count.index], "acl", null)
  policy        = lookup(var.bucket[count.index], "policy", null)
  force_destroy = lookup(var.bucket[count.index], "force_destroy", true)
  request_payer = lookup(var.bucket[count.index], "request_payer", null)

  dynamic "versioning" {
    for_each = lookup(var.bucket[count.index], "versioning")
    content {
      enabled    = lookup(versioning.value, "enabled", false)
      mfa_delete = lookup(versioning.value, "mfa_delete", false)
    }
  }

  dynamic "cors_rule" {
    for_each = lookup(var.bucket[count.index], "cors_rule")
    content {
      allowed_methods = [lookup(cors_rule.value, "allowed_methods")]
      allowed_origins = [lookup(cors_rule.value, "allowed_origins")]
      allowed_headers = [lookup(cors_rule.value, "allowed_headers", null)]
      expose_headers  = [lookup(cors_rule.value, "expose_headers", null)]
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds", null)
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = lookup(var.bucket[count.index], "server_side_encryption_configuration")
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = lookup(server_side_encryption_configuration.value, "sse_algorithm")
        }
      }
    }
  }

  dynamic "replication_configuration" {
    for_each = lookup(var.bucket[count.index], "replication_configuration")
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
    for_each = lookup(var.bucket[count.index], "website")
    content {
      index_document           = lookup(website.value, "index_document", null)
      error_document           = lookup(website.value, "error_document", null)
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
      routing_rules            = lookup(website.value, "routing_rules", null)
    }
  }

  dynamic "logging" {
    for_each = lookup(var.bucket[count.index], "logging")
    content {
      target_bucket = lookup(logging.value, "target_bucket")
      target_prefix = lookup(logging.value, "target_prefix", null)
    }
  }

  dynamic "object_lock_configuration" {
    for_each = lookup(var.bucket[count.index], "object_lock_configuration")
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
    for_each = lookup(var.bucket[count.index], "lifecycle_rule")
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

resource "aws_s3_account_public_access_block" "public_access_block" {
  block_public_acls       = ""
  block_public_policy     = ""
  restrict_public_buckets = ""
  ignore_public_acls      = ""
  account_id              = ""
}
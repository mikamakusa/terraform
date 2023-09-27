resource "aws_s3_bucket" "s3_bucket" {
  for_each            = var.s3_bucket
  bucket              = join("-", [each.key, "storage"])
  bucket_prefix       = each.value.bucket_prefix
  force_destroy       = each.value.force_destroy
  object_lock_enabled = each.value.object_lock_enabled
}

resource "aws_s3_bucket_accelerate_configuration" "s3_bucket_accelerate" {
  for_each = var.s3_bucket
  bucket   = aws_s3_bucket.s3_bucket[join("-", [each.key, "storage"])].id
  status   = each.value.s3_bucket_accelerate == "true" ? "Enabled" : "Suspended"
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = ""
}

resource "aws_s3_bucket_analytics_configuration" "s3_bucket_analytics" {
  for_each = var.s3_bucket_analytics
  bucket   = aws_s3_bucket.s3_bucket[join("-", [each.value.bucket, "storage"])].id
  name     = each.key
  storage_class_analysis {
    data_export {
      destination {
        s3_bucket_destination {
          bucket_arn = aws_s3_bucket.s3_bucket[join("-", [each.value.bucket, "analytics"])].arn
        }
      }
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "s3_bucket_cors_configuration" {
  for_each = var.s3_bucket_cors
  bucket   = aws_s3_bucket.s3_bucket[join("-", [each.value.bucket, "storage"])].id

  dynamic "cors_rule" {
    for_each = each.value.cors_rule
    content {
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      allowed_headers = cors_rule.value.allowed_headers
      expose_headers  = cors_rule.value.expose_headers
      id              = cors_rule.value.id
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "s3_bucket_tiering" {
  for_each = var.s3_bucket_tiering
  bucket   = aws_s3_bucket.s3_bucket[join("-", [each.value.bucket, "storage"])].id
  name     = each.key
  status   = each.value.status
  filter {
    prefix = each.value.filter_prefix
  }
  tiering {
    access_tier = each.value.access_tier
    days        = each.value.days
  }
}

resource "aws_s3_bucket_inventory" "s3_bucket_inventory" {
  bucket                   = ""
  included_object_versions = ""
  name                     = ""

  schedule {
    frequency = ""
  }

  destination {
    bucket {
      bucket_arn = ""
      format     = ""
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket_lifecycle" {
  bucket = ""
}

resource "aws_s3_bucket_logging" "s3_bucket_logging" {
  bucket        = ""
  target_bucket = ""
  target_prefix = ""
}

resource "aws_s3_bucket_metric" "s3_bucket_metric" {
  bucket = ""
  name   = ""
}

resource "aws_s3_bucket_notification" "s3_bucket_notification" {
  bucket = ""
}

resource "aws_s3_bucket_object_lock_configuration" "s3_bucket_object_lock" {
  bucket = ""
}

resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  bucket = ""
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = ""
  policy = ""
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = ""
}

resource "aws_s3_bucket_replication_configuration" "replication_configuration" {
  bucket = ""
  role   = ""
}

resource "aws_s3_bucket_request_payment_configuration" "request_payment_configuration" {
  bucket = ""
  payer  = ""
}

resource "aws_s3_bucket_server_side_encryption_configuration" "serverside_encryption_configuration" {
  bucket = ""
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = ""
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = ""
}
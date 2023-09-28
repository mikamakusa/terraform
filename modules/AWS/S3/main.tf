resource "aws_s3_bucket" "this" {
  for_each            = var.bucket
  bucket              = each.key
  bucket_prefix       = each.value.bucket_prefix
  force_destroy       = each.value.force_destroy
  object_lock_enabled = each.value.object_lock_enabled
  tags                = {}
}

resource "aws_s3_bucket" "logging" {
  for_each            = var.bucket
  bucket              = join("-", [each.key, "logging"])
  bucket_prefix       = each.value.bucket_prefix
  force_destroy       = each.value.force_destroy
  object_lock_enabled = each.value.object_lock_enabled
}

resource "aws_s3_bucket" "analytics" {
  for_each            = var.bucket
  bucket              = join("-", [each.key, "analythics"])
  bucket_prefix       = each.value.bucket_prefix
  force_destroy       = each.value.force_destroy
  object_lock_enabled = each.value.object_lock_enabled
}

resource "aws_s3_bucket_accelerate_configuration" "this" {
  for_each = var.bucket
  bucket   = aws_s3_bucket.this[each.key].id
  status   = each.value.accelerate == true ? "Enabled" : "Suspended"
}

resource "aws_s3_bucket_versioning" "this" {
  for_each = var.bucket
  bucket   = aws_s3_bucket.this[each.key].id
  versioning_configuration {
    status = each.value.versioning == true ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_intelligent_tiering_configuration" "this" {
  for_each = var.bucket
  bucket   = aws_s3_bucket.this[each.key].id
  name     = each.value.tiering_name
  dynamic "tiering" {
    for_each = each.value.tiering
    content {
      access_tier = tiering.value.access_tier
      days        = tiering.value.days
    }
  }
}

resource "aws_s3_bucket_logging" "this" {
  for_each      = var.bucket && length(var.logging)
  bucket        = aws_s3_bucket.this[each.key].id
  target_bucket = aws_s3_bucket.logging[var.logging[0]["target_bucket"]].id
  target_prefix = var.logging[0]["target_prefix"]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  for_each = var.bucket && length(var.encryption)
  bucket   = aws_s3_bucket.this[each.key].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.encryption[0]["sse_algorithm"]
      kms_master_key_id = var.encryption[0]["kms_master_key_id"]
    }
  }
}

resource "aws_s3_bucket_analytics_configuration" "this" {
  for_each = var.bucket && length(var.analytics)
  bucket   = aws_s3_bucket.this
  name     = var.analytics[0]["name"]
  storage_class_analysis {
    data_export {
      destination {
        s3_bucket_destination {
          bucket_arn = aws_s3_bucket.analytics[each.key].arn
        }
      }
    }
  }
}

resource "aws_s3_bucket_metric" "this" {
  for_each = var.bucket
  bucket = aws_s3_bucket.this[each.key].id
  name   = "EntireBucket"
}
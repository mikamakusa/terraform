output "buckets" {
  value = try(aws_s3_bucket.this, aws_s3_bucket.analytics, aws_s3_bucket.logging)
}

output "metric" {
  value = aws_s3_bucket_metric.this
}

output "analytics_configuration" {
  value = aws_s3_bucket_analytics_configuration.this
}

output "encryption" {
  value = aws_s3_bucket_server_side_encryption_configuration.this
}

output "versioning" {
  value = aws_s3_bucket_versioning.this
}

output "logging" {
  value = aws_s3_bucket_logging.this
}

output "tiering" {
  value = aws_s3_bucket_intelligent_tiering_configuration.this
}

output "accelerate" {
  value = aws_s3_bucket_accelerate_configuration.this
}
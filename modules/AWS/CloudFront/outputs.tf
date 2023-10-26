output "cache_policy" {
  value = try(
    aws_cloudfront_cache_policy.this
  )
}

output "buckets" {
  value = try(
    aws_s3_bucket.this,
    aws_s3_bucket.logging,
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_ownership_controls.logging,
    aws_s3_bucket_acl.this,
    aws_s3_bucket_acl.logging
  )
}

output "distribution" {
  value = try(
    aws_cloudfront_distribution.this
  )
}

output "function" {
  value = try(
    aws_cloudfront_function.this
  )
}

output "monitoring_subscription" {
  value = try(
    aws_cloudfront_monitoring_subscription.this
  )
}

output "realtime_log_config" {
  value = try(
    aws_cloudfront_realtime_log_config.this
  )
}

output "response_headers_policy" {
  value = try(
    aws_cloudfront_response_headers_policy.this
  )
}
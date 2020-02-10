output "cloudfront_access_identity_path" {
  value = aws_cloudfront_origin_access_identity.cloudfront_origin_access_identity.*.cloudfront_access_identity_path
}
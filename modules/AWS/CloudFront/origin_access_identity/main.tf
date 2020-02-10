resource "aws_cloudfront_origin_access_identity" "cloudfront_origin_access_identity" {
  count   = length(var.cloudfront_origin_access_identity)
  comment = lookup(var.cloudfront_origin_access_identity[count.index], "comment", null)
}
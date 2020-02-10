resource "aws_cloudfront_public_key" "cloudfront_public_key" {
  count       = length(var.cloudfront_public_key)
  encoded_key = file(join(".", [join("/", [path.cwd, "key", lookup(var.cloudfront_public_key[count.index], "encoded_key")]), "pem"]))
  name        = lookup(var.cloudfront_public_key[count.index], "name", null)
  comment     = lookup(var.cloudfront_public_key[count.index], "comment", null)
}
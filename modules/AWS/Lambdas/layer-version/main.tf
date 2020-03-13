resource "aws_lambda_layer_version" "lambda_layer_version" {
  count               = length(var.lambda_layer_version)
  layer_name          = lookup(var.lambda_layer_version[count.index], "layer_name")
  filename            = join(".", [join("/", [path.cwd, "layers", lookup(var.lambda_layer_version[count.index], "filename")]), "zip"])
  source_code_hash    = filebase64sha256(join(".", [join("/", [path.cwd, "layers", lookup(var.lambda_layer_version[count.index], "filename")]), "zip"]))
  s3_bucket           = lookup(var.lambda_layer_version[count.index], "filename") == "" ? "" : lookup(var.lambda_layer_version[count.index], "s3_bucket", null)
  s3_key              = lookup(var.lambda_layer_version[count.index], "filename") == "" ? "" : lookup(var.lambda_layer_version[count.index], "s3_key", null)
  s3_object_version   = lookup(var.lambda_layer_version[count.index], "filename") == "" ? "" : lookup(var.lambda_layer_version[count.index], "s3_object_version", null)
  description         = lookup(var.lambda_layer_version[count.index], "description", null)
  license_info        = lookup(var.lambda_layer_version[count.index], "license_info", null)

}
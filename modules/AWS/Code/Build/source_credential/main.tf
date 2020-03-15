resource "aws_codebuild_source_credential" "source_credential" {
  count       = length(var.source_credential)
  auth_type   = lookup(var.source_credential[count.index], "auth_type")
  server_type = lookup(var.source_credential[count.index], "server_type")
  token       = lookup(var.source_credential[count.index], "token")
  user_name   = lookup(var.source_credential[count.index], "user_name")
}
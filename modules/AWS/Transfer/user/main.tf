resource "aws_transfer_user" "transfer_user" {
  count          = length(var.transfer_user)
  role           = element(var.role_id, lookup(var.transfer_user[count.index], "role_id"))
  server_id      = element(var.server_id, lookup(var.transfer_user[count.index], "server_id"))
  user_name      = lookup(var.transfer_user[count.index], "user_name")
  policy         = file(join(".", [join("/", [path.cwd, "policy", lookup(var.transfer_user[count.index], "policy")]), "json"]))
  home_directory = format("/%s", element(var.bucket_id, lookup(var.transfer_user[count.index], "bucket_id")), element(var.bucket_key_id, lookup(var.transfer_user[count.index], "bucket_key_id")))
}
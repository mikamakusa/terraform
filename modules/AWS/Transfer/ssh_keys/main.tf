resource "aws_transfer_ssh_key" "transfer_ssh_key" {
  count     = length(var.transfer_ssh_key)
  body      = file(join(".", [join("/", [path.cwd, "keys", lookup(var.transfer_ssh_key[count.index], "name")]) ,"pub"]))
  server_id = element(var.server_id, lookup(var.transfer_ssh_key[count.index], "server_id"))
  user_name = element(var.user_name, lookup(var.transfer_ssh_key[count.index], "user_id"))
}
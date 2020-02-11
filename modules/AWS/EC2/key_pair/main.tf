resource "aws_key_pair" "key_pair" {
  count      = length(var.key_pair)
  key_name   = lookup(var.key_pair[count.index], "key_name")
  public_key = file(join(".", [join("/", [path.cwd, "keys", lookup(var.key_pair[count.index], "public_key")]), "pub"]))
}
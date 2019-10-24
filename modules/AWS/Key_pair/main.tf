resource "aws_key_pair" "aws_keypair" {
  count      = length(var.keypairs)
  key_name   = lookup(var.keypairs[count.index],"key_name")
  public_key = lookup(var.keypairs[count.index],"public_key")
}

resource "aws_ami_copy" "ami_copy" {
  count             = length(var.ami_copy)
  name              = lookup(var.ami_copy[count.index], "name")
  source_ami_id     = element(var.ami, lookup(var.ami_copy[count.index], "source_ami_id"))
  source_ami_region = lookup(var.ami_copy[count.index], "source_ami_region")
  encrypted         = lookup(var.ami_copy[count.index], "encrypted", null)
  kms_key_id        = element(var.kms_key_id, lookup(var.ami_copy[count.index], "kms_key_id", null))
  tags              = lookup(var.ami_copy[count.index], "tags", null)
}
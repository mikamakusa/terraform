resource "aws_instance" "aws_instance" {
  count                       = length(var.instance)
  ami                         = var.ami
  instance_type               = lookup(var.instance[count.index], "instance_type")
  key_name                    = var.key_pair
  availability_zone           = lookup(var.instance[count.index], "availability_zone")
  placement_group             = lookup(var.instance[count.index], "placement_group")
  disable_api_termination     = lookup(var.instance[count.index], "disable_api_termination")
  monitoring                  = lookup(var.instance[count.index], "monitoring")
  associate_public_ip_address = lookup(var.instance[count.index], "associate_public_ip_address")
  iam_instance_profile        = lookup(var.instance[count.index], "iam_instance_profile")
  security_groups             = [var.security_groups]
  subnet_id                   = var.subnet_id
  root_block_device           = lookup(var.instance[count.index], "root_block_device")
}

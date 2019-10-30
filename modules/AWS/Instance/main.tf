resource "aws_instance" "aws_instance" {
  count                       = length(var.instance)
  ami                         = lookup(var.instance[count.index],"ami")
  instance_type               = lookup(var.instance[count.index], "instance_type")
  key_name                    = var.key_pair
  availability_zone           = lookup(var.instance[count.index], "availability_zone")
  placement_group             = lookup(var.instance[count.index], "placement_group")
  disable_api_termination     = lookup(var.instance[count.index], "disable_api_termination")
  monitoring                  = lookup(var.instance[count.index], "monitoring")
  associate_public_ip_address = lookup(var.instance[count.index], "associate_public_ip_address")
  iam_instance_profile        = lookup(var.instance[count.index], "iam_instance_profile")
  security_groups             = [join("", data.terraform_remote_state.security_groups.id)]
  subnet_id                   = element(data.terraform_remote_state.vpc.outputs.private_subnets, 0)
  root_block_device           = lookup(var.instance[count.index], "root_block_device")
}

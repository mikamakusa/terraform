resource "aws_eip" "eip" {
  count                     = length(var.eip)
  instance                  = element(var.instance_id, lookup(var.eip[count.index], "instance_id", null))
  network_interface         = element(var.network_interface_id, lookup(var.eip[count.index], "network_interface_id", null))
  associate_with_private_ip = lookup(var.eip[count.index], "associate_with_private_ip", false)
  vpc                       = element(var.vpc_id, lookup(var.eip[count.index], "vpc_id"))
}
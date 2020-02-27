resource "aws_eip" "eip" {
  count                     = length(var.eip)
//  instance                  = lookup(var.eip[count.index], "instance_id") == [] ? [] : element(var.instance_id, lookup(var.eip[count.index], "instance_id"))
//  network_interface         = lookup(var.eip[count.index], "network_interface_id") == [] ? [] : element(var.network_interface_id, lookup(var.eip[count.index], "network_interface_id"))
  associate_with_private_ip = lookup(var.eip[count.index], "associate_with_private_ip", false)
  vpc                       = true
}
resource "aws_eip" "eip" {
  count                     = length(var.eip)
  instance                  = element(var.instance_id, lookup(var.eip[count.index], "instance_id"))
  network_interface         = element(var.network_interface_id, lookup(var.eip[count.index], "network_interface_id"))
  associate_with_private_ip = lookup(var.eip[count.index], "associate_with_private_ip")
  vpc                       = lookup(var.eip[count.index], "vpc")
  public_ipv4_pool          = lookup(var.eip[count.index], "vpc") == true ? lookup(var.eip[count.index], "public_ipv4_pool") : ""
}
resource "aws_ami" "aws_ami" {
  name                = "${lookup(var.ami,"name")}"
  architecture        = "x86-64"
  virtualization_type = "${lookup(var.ami,"virtualization_type")}"
  root_device_name    = "${lookup(var.ami,"root_device_name")}"
}

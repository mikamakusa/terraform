resource "aws_instance" "aws_instance" {
  count                   = "${length(var.instance)}"
  ami                     = "${var.ami}"
  instance_type           = "${lookup(var.instance[count.index],"instance_type")}"
  key_name                = "${var.key_pair}"
  availability_zone       = "${lookup(var.instance[count.index],"availability_zone")}"
  placement_group         = "${lookup(var.instance[count.index],"placement_group")}"
  disable_api_termination = "${lookup(var.instance[count.index],"disable_api_termination")}"
  monitoring              = "${lookup(var.instance[count.index],"monitoring")}"
}

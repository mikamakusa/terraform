resource "aws_ami_from_instance" "ami_from_instance" {
  count                   = length(var.ami_from_instance)
  name                    = lookup(var.ami_from_instance[count.index], "name")
  source_instance_id      = element(var.source_instance_id, lookup(var.ami_from_instance[count.index], "source_instance_id"))
  snapshot_without_reboot = lookup(var.ami_from_instance[count.index], "snapshot_without_reboot", false)
  tags                    = lookup(var.ami_from_instance[count.index], "tags", null)
}
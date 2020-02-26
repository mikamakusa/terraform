resource "aws_launch_configuration" "launch_configuration" {
  count                       = length(var.launch_configuration)
  image_id                    = lookup(var.launch_configuration[count.index], "image_id")
  instance_type               = lookup(var.launch_configuration[count.index], "instance_type")
  security_groups             = [element(var.security_group_ids, lookup(var.launch_configuration[count.index], "security_group_id"))]
  associate_public_ip_address = lookup(var.launch_configuration[count.index], "associate_public_ip_address", false)
  iam_instance_profile        = element(var.iam_instance_profile_id, lookup(var.launch_configuration[count.index], "iam_instance_profile_id", null))
  key_name                    = element(var.key_pair_name, lookup(var.launch_configuration[count.index], "key_pair_id"))
  enable_monitoring           = lookup(var.launch_configuration[count.index], "enable_monitoring", true)
  spot_price                  = lookup(var.launch_configuration[count.index], "spot_price", null)
  placement_tenancy           = lookup(var.launch_configuration[count.index], "placement_tenancy", null)

  dynamic "root_block_device" {
    for_each = lookup(var.launch_configuration[count.index], "root_block_device")
    content {
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", true)
      encrypted             = lookup(root_block_device.value, "encrypted", true)
    }
  }

  dynamic "lifecycle" {
    for_each = lookup(var.launch_configuration[count.index], "lifecycle")
    content {
      prevent_destroy       = lookup(lifecycle.value, "prevent_destroy", false)
      create_before_destroy = lookup(lifecycle.value, "create_before_destroy", false)
    }
  }
}
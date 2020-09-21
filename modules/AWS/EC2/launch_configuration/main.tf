resource "aws_launch_configuration" "launch_configuration" {
  count                       = length(var.launch_configuration)
  name                        = lookup(var.launch_configuration[count.index], "name")
  image_id                    = lookup(var.launch_configuration[count.index], "image_id")
  instance_type               = lookup(var.launch_configuration[count.index], "instance_type")
  security_groups             = [element(var.security_group_ids, lookup(var.launch_configuration[count.index], "security_group_id"))]
  associate_public_ip_address = lookup(var.launch_configuration[count.index], "associate_public_ip_address", false)
  iam_instance_profile        = element(var.iam_instance_profile_id, lookup(var.launch_configuration[count.index], "iam_instance_profile_id"))
  key_name                    = element(var.key_pair_name, lookup(var.launch_configuration[count.index], "key_pair_id"))
  user_data                   = element(var.user_data, lookup(var.launch_configuration[count.index], "user_data_id"))
  enable_monitoring           = lookup(var.launch_configuration[count.index], "enable_monitoring", true)
  spot_price                  = lookup(var.launch_configuration[count.index], "spot_price", null)
  placement_tenancy           = lookup(var.launch_configuration[count.index], "placement_tenancy", null)

  dynamic "ebs_block_device" {
    for_each = lookup(var.launch_configuration[count.index], "ebs_block_device")
    content {
      device_name           = lookup(ebs_block_device.value, "device_name")
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id")
      volume_type           = lookup(ebs_block_device.value, "volume_type")
      volume_size           = lookup(ebs_block_device.value, "volume_size")
      iops                  = lookup(ebs_block_device.value, "iops")
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination")
      encrypted             = lookup(ebs_block_device.value, "encrypted")
      no_device             = lookup(ebs_block_device.value, "no_device")
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = lookup(var.launch_configuration[count.index], "ephemeral_block_device")
    content {
      device_name  = lookup(ephemeral_block_device.value, "device_name")
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name")
    }
  }

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
}

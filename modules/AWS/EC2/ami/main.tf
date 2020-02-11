resource "aws_ami" "ami" {
  count               = length(var.ami)
  name                = lookup(var.ami[count.index], "name")
  description         = lookup(var.ami[count.index], "description", null)
  ena_support         = lookup(var.ami[count.index], "ena_support", false)
  root_device_name    = lookup(var.ami[count.index], "root_device_name", null)
  virtualization_type = lookup(var.ami[count.index], "virtualization_type", "hvm")
  architecture        = lookup(var.ami[count.index], "architecture", "x86_64")
  image_location      = lookup(var.ami[count.index], "image_location")
  kernel_id           = lookup(var.ami[count.index], "kernel_id")
  ramdisk_id          = lookup(var.ami[count.index], "ramdisk_id", null)
  tags                = lookup(var.ami[count.index], "tags", null)

  dynamic "ebs_block_device" {
    for_each = lookup(var.ami[count.index], "ebs_block_device")
    content {
      device_name           = lookup(ebs_block_device.value, "device_name")
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", true)
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", "standard")
      snapshot_id           = lookup(ebs_block_device.value, "snasphot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size")
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = lookup(var.ami[count.index], "ephemeral_block_device")
    content {
      device_name  = lookup(ephemeral_block_device.value, "device_name")
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  dynamic "lifecycle" {
    for_each = lookup(var.ami[count.index], "lifecycle")
    content {
      create_before_destroy = lookup(lifecycle.value, "create_before_destroy", null)
      prevent_destroy       = lookup(lifecycle.value, "prevent_destroy", null)
      ignore_changes        = [lookup(lifecycle.value, "ignore_changes", null)]
    }
  }
}
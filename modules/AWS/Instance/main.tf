resource "aws_key_pair" "instance_key_pair" {
  count      = length(var.key_pair)
  key_name   = lookup(var.key_pair[count.index], "key_name")
  public_key = lookup(var.key_pair[count.index], "public_key")
}

resource "aws_instance" "aws_instance" {
  count                       = length(var.instance)
  ami                         = lookup(var.instance[count.index], "ami")
  instance_type               = lookup(var.instance[count.index], "instance_type")
  key_name                    = element(aws_key_pair.instance_key_pair.*.key_name, lookup(var.instance[count.index], "key_id"))
  availability_zone           = lookup(var.instance[count.index], "availability_zone")
  placement_group             = lookup(var.instance[count.index], "placement_group")
  disable_api_termination     = lookup(var.instance[count.index], "disable_api_termination")
  monitoring                  = lookup(var.instance[count.index], "monitoring")
  associate_public_ip_address = lookup(var.instance[count.index], "associate_public_ip_address")
  iam_instance_profile        = lookup(var.instance[count.index], "iam_instance_profile")
  security_groups             = [var.security_groups]
  subnet_id                   = var.subnet_id
  root_block_device           = lookup(var.instance[count.index], "root_block_device")
  vpc_security_group_ids      = [lookup(var.instance[count.index], "vpc_security_group_ids") ? aws_instance.aws_instance.*.security_groups : ""]
  source_dest_check           = lookup(var.instance[count.index], "source_dest_check", null)
  tenancy                     = lookup(var.instance[count.index], "tenancy", null)
  host_id                     = lookup(var.instance[count.index], "host_id", null)
  cpu_core_count              = lookup(var.instance[count.index], "cpu_core_count", null)
  cpu_threads_per_core        = lookup(var.instance[count.index], "cpu_threads_per_core", null)
  ebs_optimized               = lookup(var.instance[count.index], "ebs_optimized", false)
  get_password_data           = lookup(var.instance[count.index], "get_password_data", false)
  private_ip                  = lookup(var.instance[count.index], "private_ip", null)
  user_data                   = lookup(var.instance[count.index], "user_data", null)

  dynamic "ebs_block_device" {
    for_each = lookup(var.instance[count.index], "ebs_block_device")
    content {
      device_name           = lookup(ebs_block_device.value, "device_name", null)
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", true)
      encrypted             = lookup(ebs_block_device.value, "encrypted", false)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = lookup(var.instance[count.index], "ephemeral_block_device")
    content {
      device_name  = lookup(ephemeral_block_device.value, "device_name", null)
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  }

  dynamic "root_block_device" {
    for_each = lookup(var.instance[count.index], "root_block_device")
    content {
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      encrypted             = lookup(root_block_device.value, "encrypted", false)
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", true)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      iops                  = lookup(root_block_device.value, "iops", null)
    }
  }

  dynamic "credit_specification" {
    for_each = lookup(var.instance[count.index], "credit_specification")
    content {
      cpu_credits = lookup(credit_specification.value, "cpu_credits", null)
    }
  }

  dynamic "tags" {
    for_each = lookup(var.instance[count.index], "tags")
    content {
      variables = tags.value
    }
  }
}

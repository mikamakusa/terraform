resource "aws_launch_template" "launch_template" {
  count                   = length(var.launch_template)
  name                    = lookup(var.launch_template[count.index], "name")
  description             = lookup(var.launch_template[count.index], "description", null)
  default_version         = lookup(var.launch_template[count.index], "default_version", null)
  disable_api_termination = lookup(var.launch_template[count.index], "disable_api_termination", null)
  ebs_optimized           = lookup(var.launch_template[count.index], "ebs_optimized", null)
  image_id                = lookup(var.launch_template[count.index], "image_id")
  instance_type           = lookup(var.launch_template[count.index], "instance_type")
  kernel_id               = lookup(var.launch_template[count.index], "kernel_id")
  key_name                = lookup(var.launch_template[count.index], "key_name")
  ram_disk_id             = lookup(var.launch_template[count.index], "ram_disk_id")
  user_data               = filebase64(join(path.cwd, "scripts", lookup(var.launch_template[count.index], "user_data")))

  dynamic "block_device_mappings" {
    for_each = [for i in lookup(var.launch_template[count.index], ) : {
      device_name  = i.device_name
      no_device    = i.no_device
      virtual_name = i.virtual_name
      ebs          = lookup(i, "ebs", null)
    }]
    content {
      device_name  = block_device_mappings.value.device_name
      no_device    = block_device_mappings.value.no_device
      virtual_name = block_device_mappings.value.virtual_name
      dynamic "ebs" {
        for_each = [for i in block_device_mappings.value.ebs : {
          delete_on_termination = i.delete_on_termination
          encrypted             = i.encrypted
          iops                  = i.iops
          kms_key_id            = i.kms_key_id
          snapshot_id           = i.snapshot_id
          volume_size           = i.volume_size
          volume_type           = i.volume_type
        }]
        content {
          delete_on_termination = ebs.value.delete_on_termination
          encrypted             = ebs.value.encrypted
          iops                  = ebs.value.iops
          kms_key_id            = element(var.kms_key_id, ebs.value.kms_key_id)
          snapshot_id           = ebs.value.snapshot_id
          volume_size           = ebs.value.volume_size
          volume_type           = ebs.value.volume_type
        }
      }
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = [for i in lookup(var.launch_template[count.index], "capacity_reservation_specification") : {
      capacity_reservation_preference = i.capacity_reservation_preference
      capacity_reservation_target = lookup(i, "capacity_reservation_target")
    }]
    content {
      capacity_reservation_preference = capacity_reservation_specification.value.capacity_reservation_preference
      dynamic "capacity_reservation_target" {
        for_each = [for i in capacity_reservation_specification.value.capacity_reservation_target : {
          capacity_reservation_id = i.capacity_reservation_id
        }]
        content {
          capacity_reservation_id = capacity_reservation_target.value.capacity_reservation_id
        }
      }
    }
  }

  dynamic "cpu_options" {
    for_each = lookup(var.launch_template[count.index], "cpu_options")
    content {
      core_count       = lookup(cpu_options.value, "core_count")
      threads_per_core = lookup(cpu_options.value, "threads_per_core")
    }
  }

  dynamic "credit_specification" {
    for_each = lookup(var.launch_template[count.index], "credit_specification")
    content {
      cpu_credits = lookup(credit_specification.value, "cpu_credits")
    }
  }

  dynamic "elastic_gpu_specifications" {
    for_each = lookup(var.launch_template[count.index], "elastic_gpu_specifications")
    content {
      type = lookup(elastic_gpu_specifications.value, "type")
    }
  }

  dynamic "elastic_inference_accelerator" {
    for_each = lookup(var.launch_template[count.index], "elastic_inference_accelerator")
    content {
      type = lookup(elastic_inference_accelerator.value, "type")
    }
  }

  dynamic "hibernation_options" {
    for_each = lookup(var.launch_template[count.index], "hibernation_options")
    content {
      configured = lookup(hibernation_options.value, "configured", false)
    }
  }

  dynamic "iam_instance_profile" {
    for_each = lookup(var.launch_template[count.index], "iam_instance_profile")
    content {
      arn  = element(var.iam_instance_profile_arn, lookup(iam_instance_profile.value, "iam_instance_profile"))
      name = element(var.iam_instance_profile_name, lookup(iam_instance_profile.value, "iam_instance_profile"))
    }
  }

  dynamic "instance_market_options" {
    for_each = [for i in lookup(var.launch_template[count.index], ) : {
      market_type = i.market_type
      spot_options = lookup(i, "spot_options", null)
    }]
    content {
      market_type = instance_market_options.value.market_type
      dynamic "spot_options" {
        for_each = [for i in instance_market_options.value.spot_options : {
          block_duration_minutes         = i.block_duration_minutes
          instance_interruption_behavior = i.instance_interruption_behavior
          max_price                      = i.max_price
          spot_instance_type             = i.spot_instance_type
          valid_until                    = i.valid_until
        }]
        content {
          block_duration_minutes         = spot_options.value.block_duration_minutes
          instance_interruption_behavior = spot_options.value.instance_interruption_behavior
          max_price                      = spot_options.value.max_price
          spot_instance_type             = spot_options.value.spot_instance_type
          valid_until                    = spot_options.value.valid_until
        }
      }
    }
  }

  dynamic "license_specification" {
    for_each = lookup(var.launch_template[count.index], "license_specification")
    content {
      license_configuration_arn = element(var.license_configuration_arn, lookup(license_specification.value, "license_configuration_id"))
    }
  }

  dynamic "metadata_options" {
    for_each = lookup(var.launch_template[count.index], "metadata_options")
    content {
      http_endpoint               = lookup(metadata_options.value, "http_endpoint")
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit")
      http_tokens                 = lookup(metadata_options.value, "http_tokens")
    }
  }

  dynamic "monitoring" {
    for_each = lookup(var.launch_template[count.index], "monitoring")
    content {
      enabled = lookup(monitoring.value, "enabled", true)
    }
  }

  dynamic "network_interfaces" {
    for_each = lookup(var.launch_template[count.index], "network_interfaces")
    content {
      associate_public_ip_address = lookup(network_interfaces.value, "associate_public_ip_address", false)
      delete_on_termination       = lookup(network_interfaces.value, "delete_on_termination", false)
      description                 = lookup(network_interfaces.value, "description")
      device_index                = lookup(network_interfaces.value, "device_index")
      ipv4_address_count          = lookup(network_interfaces.value, "ipv4_address_count")
      ipv4_addresses              = [lookup(network_interfaces.value, "ipv4_addresses")]
      ipv6_address_count          = lookup(network_interfaces.value, "ipv6_address_count")
      ipv6_addresses              = [lookup(network_interfaces.value, "ipv6_addresses")]
      security_groups             = [lookup(network_interfaces.value, "security_groups")]
      subnet_id                   = element(var.subnet_id, lookup(network_interfaces.value, "subnet_id"))
      private_ip_address          = lookup(network_interfaces.value, "private_ip_address")
      network_interface_id        = lookup(network_interfaces.value, "network_interface_id")
    }
  }

  dynamic "placement" {
    for_each = lookup(var.launch_template[count.index], "placement")
    content {
      affinity          = lookup(placement.value, "affinity")
      availability_zone = lookup(placement.value, "availability_zone")
      group_name        = lookup(placement.value, "group_name")
      host_id           = lookup(placement.value, "host_id")
      spread_domain     = lookup(placement.value, "spread_domain")
      tenancy           = lookup(placement.value, "tenancy")
      partition_number  = lookup(placement.value, "partition_number")
    }
  }

  dynamic "tag_specifications" {
    for_each = [for i in lookup(var.launch_template[count.index], "tag_specifications") : {
      resource_type = i.resource_type
      tags = lookup(i, "tags")
    }]
    content {
      resource_type = lookup(tag_specifications.value, "resource_type")
      dynamic "tags" {
        for_each = [for i in tag_specifications.value.tags : {
          tags = i.tags
        }]
        content {
          variables = tags.value
        }
      }
    }
  }
}

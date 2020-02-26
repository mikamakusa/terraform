resource "openstack_compute_flavor_v2" "flavor" {
  count = length(var.flavor)
  disk  = lookup(var.flavor[count.index], "disk")
  name  = lookup(var.flavor[count.index], "name")
  ram   = lookup(var.flavor[count.index], "ram")
  vcpus = lookup(var.flavor[count.index], "vcpus")
}

resource "openstack_compute_flavor_access_v2" "flavor_access" {
  count     = length(var.flavor) == "0" ? "0" : length(var.flavor_access)
  flavor_id = element(openstack_compute_flavor_v2.flavor.*.id, lookup(var.flavor_access[count.index], "flavor_id"))
  tenant_id = var.tenant_id
}

resource "openstack_compute_instance_v2" "instance" {
  count               = length(var.instance)
  name                = lookup(var.instance[count.index], "name")
  image_id            = lookup(var.instance[count.index], "image_id", null)
  flavor_id           = lookup(var.instance[count.index], "flavor_id", null)
  user_data           = file("${path.cwd}/user_data/${lookup(var.instance[count.index], "name")}.sh")
  security_groups     = [var.security_groups]
  availability_zone   = lookup(var.instance[count.index], "availability_zones", null)
  metadata            = lookup(var.instance[count.index], "metadata", null)
  admin_pass          = lookup(var.instance[count.index], "admin_pass", null)
  access_ip_v4        = lookup(var.instance[count.index], "access_ip_v4", null)
  access_ip_v6        = lookup(var.instance[count.index], "access_ip_v6", null)
  power_state         = lookup(var.instance[count.index], "power_state", null)
  stop_before_destroy = lookup(var.instance[count.index], "stop_before_destroy", true)
  force_delete        = lookup(var.instance[count.index], "force_delete", true)

  dynamic "personality" {
    for_each = lookup(var.instance[count.index], "personality")
    content {
      content = lookup(personality.value, "content")
      file    = lookup(personality.value, "file")
    }
  }

  dynamic "network" {
    for_each = lookup(var.instance[count.index], "network")
    content {
      uuid           = lookup(network.value, "uuid", null)
      name           = lookup(network.value, "name", null)
      port           = lookup(network.value, "port", null)
      fixed_ip_v4    = lookup(network.value, "fied_ip_v4", null)
      fixed_ip_v6    = lookup(network.value, "fied_ip_v6", null)
      floating_ip    = lookup(network.value, "floating_ip", null)
      access_network = lookup(network.value, "access_network", null)
    }
  }

  dynamic "block_device" {
    for_each = lookup(var.instance[count.index], "block_device")
    content {
      source_type           = lookup(block_device.value, "source_type")
      uuid                  = lookup(block_device.value, "uuid")
      volume_size           = lookup(block_device.value, "volume_size")
      boot_index            = lookup(block_device.value, "boot_index", null)
      destination_type      = lookup(block_device.value, "destination_type", null)
      delete_on_termination = lookup(block_device.value, "delete_on_termination", null)
      device_type           = lookup(block_device.value, "device_type", null)
      disk_bus              = lookup(block_device.value, "disk_bus", null)
    }
  }

  dynamic "scheduler_hints" {
    for_each = lookup(var.instance[count.index], "scheduler_hints")
    content {
      group                 = lookup(scheduler_hints.value, "group", null)
      different_host        = [lookup(scheduler_hints.value, "different_hosts", null)]
      same_host             = [lookup(scheduler_hints.value, "same_host", null)]
      query                 = [lookup(scheduler_hints.value, "query", null)]
      target_cell           = lookup(scheduler_hints.value, "target_cell", null)
      build_near_host_ip    = lookup(scheduler_hints.value, "build_near_host_ip", null)
      additional_properties = lookup(scheduler_hints.value, "additional_properties", null)
    }
  }

  dynamic "personality" {
    for_each = lookup(var.instance[count.index], "personality")
    content {
      content = lookup(personality.value, "content")
      file    = file(join(".", [join("/", [path.cwd, "personality", lookup(personality.value, "file")])]))
    }
  }

  dynamic "vendor_options" {
    for_each = lookup(var.instance[count.index], "vendor_options")
    content {
      ignore_resize_confirmation = lookup(vendor_options.value, "ignore_resize_confirmation", null)
    }
  }
}
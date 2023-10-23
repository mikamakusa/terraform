resource "openstack_compute_flavor_v2" "flavor" {
  count        = length(var.flavors)
  disk         = lookup(var.flavors[count.index], "disk")
  name         = lookup(var.flavors[count.index], "name")
  ram          = lookup(var.flavors[count.index], "ram")
  vcpus        = lookup(var.flavors[count.index], "vcpus")
  flavor_id    = lookup(var.flavors[count.index], "flavor_id")
  ephemeral    = lookup(var.flavors[count.index], "ephemeral")
  swap         = lookup(var.flavors[count.index], "swap")
  is_public    = lookup(var.flavors[count.index], "is_public")
  rx_tx_factor = lookup(var.flavors[count.index], "rx_tx_factor")
  extra_specs  = lookup(var.flavors[count.index], "extra_specs")
}

resource "openstack_compute_floatingip_v2" "this" {
  count  = length(var.floatingip) && var.floating_ip_address == null
  pool   = lookup(var.floatingip[count.index], "pool")
  region = lookup(var.floatingip[count.index], "region")
}

resource "openstack_images_image_v2" "this" {
  count                 = length(var.os_images) && var.images == null
  container_format      = lookup(var.os_images[count.index], "container_format")
  disk_format           = lookup(var.os_images[count.index], "disk_format")
  name                  = lookup(var.os_images[count.index], "name")
  local_file_path       = lookup(var.os_images[count.index], "local_file_path")
  image_cache_path      = lookup(var.os_images[count.index], "image_cache_path")
  image_source_url      = lookup(var.os_images[count.index], "image_source_url")
  image_source_username = lookup(var.os_images[count.index], "image_source_username")
  image_source_password = lookup(var.os_images[count.index], "image_source_password")
  min_disk_gb           = lookup(var.os_images[count.index], "min_disk_gb")
  min_ram_mb            = lookup(var.os_images[count.index], "min_ram_mb")
  image_id              = lookup(var.os_images[count.index], "image_id")
  properties            = lookup(var.os_images[count.index], "properties")
  protected             = lookup(var.os_images[count.index], "protected")
  hidden                = lookup(var.os_images[count.index], "hidden")
  region                = lookup(var.os_images[count.index], "region")
  tags                  = lookup(var.os_images[count.index], "tags")
  verify_checksum       = lookup(var.os_images[count.index], "verify_checksum")
  web_download          = lookup(var.os_images[count.index], "web_download")
  decompress            = lookup(var.os_images[count.index], "decompress")
  visibility            = lookup(var.os_images[count.index], "visibility")
}

resource "openstack_compute_instance_v2" "instance" {
  count               = length(var.instance)
  name                = lookup(var.instance[count.index], "name")
  region              = lookup(var.instance[count.index], "region")
  image_id            = var.images != null ? data.openstack_images_image_v2.this.id : element(openstack_images_image_v2.this.id, lookup(var.instance[count.index], "image_id"))
  flavor_id           = var.flavor != null ? data.openstack_compute_flavor_v2.this.id : element(openstack_compute_flavor_v2.flavor.id, lookup(var.instance[count.index], "flavor_id"))
  user_data           = file("${path.cwd}/user_data/${lookup(var.instance[count.index], "user_data")}.sh")
  security_groups     = lookup(var.instance[count.index], "security_groups")
  availability_zone   = lookup(var.instance[count.index], "availability_zones")
  metadata            = lookup(var.instance[count.index], "metadata")
  admin_pass          = sensitive(lookup(var.instance[count.index], "admin_pass"))
  key_pair            = lookup(var.instance[count.index], "key_pair")
  power_state         = lookup(var.instance[count.index], "power_state")
  stop_before_destroy = lookup(var.instance[count.index], "stop_before_destroy")
  force_delete        = lookup(var.instance[count.index], "force_delete")

  dynamic "personality" {
    for_each = lookup(var.instance[count.index], "personality") == null ? [] : ["personality"]
    content {
      content = lookup(personality.value, "content")
      file    = file(join(".", [join("/", [path.cwd, "personality", lookup(personality.value, "file")])]))
    }
  }

  dynamic "network" {
    for_each = lookup(var.instance[count.index], "network") == null ? [] : ["network"]
    content {
      uuid           = lookup(network.value, "uuid")
      name           = lookup(network.value, "name")
      port           = lookup(network.value, "port")
      fixed_ip_v4    = lookup(network.value, "fied_ip_v4")
      fixed_ip_v6    = lookup(network.value, "fied_ip_v6")
      access_network = lookup(network.value, "access_network")
    }
  }

  dynamic "block_device" {
    for_each = lookup(var.instance[count.index], "block_device") == null ? [] : ["block_device"]
    content {
      source_type           = lookup(block_device.value, "source_type")
      uuid                  = lookup(block_device.value, "uuid")
      volume_size           = lookup(block_device.value, "volume_size")
      boot_index            = lookup(block_device.value, "boot_index")
      destination_type      = lookup(block_device.value, "destination_type")
      delete_on_termination = lookup(block_device.value, "delete_on_termination")
      device_type           = lookup(block_device.value, "device_type")
      disk_bus              = lookup(block_device.value, "disk_bus")
    }
  }

  dynamic "scheduler_hints" {
    for_each = lookup(var.instance[count.index], "scheduler_hints") == null ? [] : ["scheduler_hints"]
    content {
      group                 = lookup(scheduler_hints.value, "group")
      different_host        = lookup(scheduler_hints.value, "different_hosts")
      same_host             = lookup(scheduler_hints.value, "same_host")
      query                 = lookup(scheduler_hints.value, "query")
      target_cell           = lookup(scheduler_hints.value, "target_cell")
      different_cell        = lookup(scheduler_hints.value, "different_cell")
      build_near_host_ip    = lookup(scheduler_hints.value, "build_near_host_ip")
      additional_properties = lookup(scheduler_hints.value, "additional_properties")
    }
  }

  dynamic "vendor_options" {
    for_each = lookup(var.instance[count.index], "vendor_options") == null ? [] : ["vendor_options"]
    content {
      ignore_resize_confirmation  = lookup(vendor_options.value, "ignore_resize_confirmation")
      detach_ports_before_destroy = lookup(vendor_options.value, "detach_ports_before_destroy")
    }
  }
}

resource "openstack_compute_floatingip_associate_v2" "this" {
  count                 = var.floating_ip_address ? 1 : 0 || length(var.floatingip_associate)
  floating_ip           = var.floating_ip_address ? data.openstack_networking_floatingip_v2.this.address : element(openstack_compute_floatingip_v2.this.*.address, lookup(var.floatingip_associate[count.index], "address_id"))
  instance_id           = var.floating_ip_address ? openstack_compute_instance_v2.instance[0].id : element(openstack_compute_instance_v2.instance.*.id, lookup(var.floatingip_associate[count.index], "instance_id"))
  region                = lookup(var.floatingip_associate[count.index], "region")
  fixed_ip              = lookup(var.floatingip_associate[count.index], "fixed_ip")
  wait_until_associated = lookup(var.floatingip_associate[count.index], "wait_until_associated")
}

resource "openstack_compute_flavor_access_v2" "flavor_access" {
  count     = length(var.flavors) == "0" ? "0" : length(var.flavor_access)
  flavor_id = element(openstack_compute_flavor_v2.flavor.*.id, lookup(var.flavor_access[count.index], "flavor_id"))
  tenant_id = var.tenant_id
}

resource "openstack_compute_secgroup_v2" "this" {
  count       = length(var.secgroup)
  description = lookup(var.secgroup[count.index], "description")
  name        = lookup(var.secgroup[count.index], "name")
  region      = lookup(var.secgroup[count.index], "region")

  dynamic "rule" {
    for_each = lookup(var.secgroup[count.index], "rule") == null ? [] : ["rule"]
    content {
      from_port     = lookup(rule.value, "from_port")
      to_port       = lookup(rule.value, "to_port")
      ip_protocol   = lookup(rule.value, "ip_protocol")
      cidr          = lookup(rule.value, "cidr")
      from_group_id = lookup(rule.value, "from_group_id")
      self          = lookup(rule.value, "self")
    }
  }
}
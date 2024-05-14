resource "openstack_compute_aggregate_v2" "this" {
  count    = length(var.aggregate_v2)
  name     = lookup(var.aggregate_v2[count.index], "name")
  region   = data.openstack_identity_project_v3.this.region
  zone     = lookup(var.aggregate_v2[count.index], "zone")
  hosts    = lookup(var.aggregate_v2[count.index], "hosts")
  metadata = merge(
    var.metadata,
    lookup(var.aggregate_v2[count.index], "metadata")
  )
}

resource "openstack_compute_flavor_access_v2" "this" {
  count     = length(var.flavor_access_v2) == "0" ? "0" : length(var.flavor_v2)
  flavor_id = try(element(openstack_compute_flavor_v2.this.*.id, lookup(var.flavor_access_v2[count.index], "flavor_id")))
  tenant_id = data.openstack_identity_project_v3.this.id
  region    = data.openstack_identity_project_v3.this.region
}

resource "openstack_compute_flavor_v2" "this" {
  count        = length(var.flavor_v2)
  disk         = lookup(var.flavor_v2[count.index], "disk")
  name         = lookup(var.flavor_v2[count.index], "name")
  ram          = lookup(var.flavor_v2[count.index], "ram")
  vcpus        = lookup(var.flavor_v2[count.index], "vcpus")
  region       = data.openstack_identity_project_v3.this.region
  description  = lookup(var.flavor_v2[count.index], "description")
  flavor_id    = lookup(var.flavor_v2[count.index], "flavor_id")
  ephemeral    = lookup(var.flavor_v2[count.index], "ephemeral")
  swap         = lookup(var.flavor_v2[count.index], "swap")
  rx_tx_factor = lookup(var.flavor_v2[count.index], "rx_tx_factor")
  is_public    = lookup(var.flavor_v2[count.index], "is_public")
  extra_specs  = lookup(var.flavor_v2[count.index], "extra_specs")
}

resource "openstack_compute_instance_v2" "this" {
  count                   = length(var.instance_v2)
  name                    = lookup(var.instance_v2[count.index], "name")
  region                  = data.openstack_identity_project_v3.this.region
  image_id                = try(data.openstack_images_image_v2.this.id)
  image_name              = try(data.openstack_images_image_v2.this.name)
  flavor_id               = try(element(openstack_compute_flavor_v2.this.*.id, lookup(var.instance_v2[count.index], "flavor_id")))
  flavor_name             = try(element(openstack_compute_flavor_v2.this.*.name, lookup(var.instance_v2[count.index], "flavor_id")))
  user_data               = lookup(var.instance_v2[count.index], "user_data")
  security_groups         = lookup(var.instance_v2[count.index], "security_groups")
  availability_zone_hints = lookup(var.instance_v2[count.index], "availability_zone_hints")
  availability_zone       = lookup(var.instance_v2[count.index], "availability_zone")
  network_mode            = lookup(var.instance_v2[count.index], "network_mode")
  metadata                = merge(
    var.metadata,
    lookup(var.instance_v2[count.index], "metadata")
  )
  config_drive            = lookup(var.instance_v2[count.index], "config_drive")
  admin_pass              = lookup(var.instance_v2[count.index], "admin_pass")
  key_pair                = lookup(var.instance_v2[count.index], "key_pair")
  stop_before_destroy     = lookup(var.instance_v2[count.index], "stop_before_destroy")
  force_delete            = lookup(var.instance_v2[count.index], "force_delete")
  power_state             = lookup(var.instance_v2[count.index], "power_state")
  tags                    = lookup(var.instance_v2[count.index], "tags")

  dynamic "network" {
    for_each = lookup(var.instance_v2[count.index], "network") == null ? [] : ["network"]
    content {
      uuid           = lookup(network.value, "uuid")
      name           = lookup(network.value, "name")
      port           = lookup(network.value, "port")
      fixed_ip_v4    = lookup(network.value, "fixed_ip_v4")
      fixed_ip_v6    = lookup(network.value, "fixed_ip_v6")
      access_network = lookup(network.value, "access_network")
    }
  }

  dynamic "block_device" {
    for_each = lookup(var.instance_v2[count.index], "block_device") == null ? [] : ["block_device"]
    content {
      source_type           = lookup(block_device.value, "source_type")
      uuid                  = lookup(block_device.value, "uuid")
      disk_bus              = lookup(block_device.value, "disk_bus")
      volume_size           = lookup(block_device.value, "volume_size")
      volume_type           = lookup(block_device.value, "volume_type")
      guest_format          = lookup(block_device.value, "guest_format")
      boot_index            = lookup(block_device.value, "boot_index")
      destination_type      = lookup(block_device.value, "destination_type")
      delete_on_termination = lookup(block_device.value, "delete_on_termination")
      device_type           = lookup(block_device.value, "device_type")
      multiattach           = lookup(block_device.value, "multiattach")
    }
  }

  dynamic "scheduler_hints" {
    for_each = lookup(var.instance_v2[count.index], "scheduler_hints") == null ? [] : ["scheduler_hints"]
    content {
      group                 = lookup(scheduler_hints.value, "group")
      different_host        = lookup(scheduler_hints.value, "different_host")
      same_host             = lookup(scheduler_hints.value, "same_host")
      query                 = lookup(scheduler_hints.value, "query")
      target_cell           = lookup(scheduler_hints.value, "target_cell")
      different_cell        = lookup(scheduler_hints.value, "different_cell")
      build_near_host_ip    = lookup(scheduler_hints.value, "build_near_host_ip")
      additional_properties = lookup(scheduler_hints.value, "additional_properties")
    }
  }

  dynamic "personality" {
    for_each = lookup(var.instance_v2[count.index], "personality") == null ? [] : ["personality"]
    content {
      content = lookup(personality.value, "content")
      file    = lookup(personality.value, "file")
    }
  }

  dynamic "vendor_options" {
    for_each = lookup(var.instance_v2[count.index], "vendor_options") == null ? [] : ["vendor_options"]
    content {
      ignore_resize_confirmation  = lookup(vendor_options.value, "ignore_resize_confirmation")
      detach_ports_before_destroy = lookup(vendor_options.value, "detach_ports_before_destroy")
    }
  }
}

resource "openstack_compute_interface_attach_v2" "this" {
  count       = length(var.interface_attach_v2) == "0" ? "0" : length(var.instance_v2)
  instance_id = try(element(openstack_compute_instance_v2.this.*.id, lookup(var.interface_attach_v2[count.index], "instance_id")))
  region      = data.openstack_identity_project_v3.this.region
  port_id     = lookup(var.interface_attach_v2[count.index], "port_id")
  network_id  = lookup(var.interface_attach_v2[count.index], "network_id")
  fixed_ip    = lookup(var.interface_attach_v2[count.index], "fixed_ip")
}

resource "openstack_compute_keypair_v2" "this" {
  count       = length(var.keypair_v2)
  name        = lookup(var.keypair_v2[count.index], "name")
  region      = data.openstack_identity_project_v3.this.region
  public_key  = lookup(var.keypair_v2[count.index], "public_key")
  user_id     = lookup(var.keypair_v2[count.index], "user_id")
  value_specs = lookup(var.keypair_v2[count.index], "value_specs")
}

resource "openstack_compute_quotaset_v2" "this" {
  count                       = length(var.quotaset_v2)
  project_id                  = data.openstack_identity_project_v3.this.id
  fixed_ips                   = lookup(var.quotaset_v2[count.index], "fixed_ips")
  floating_ips                = lookup(var.quotaset_v2[count.index], "floating_ips")
  injected_file_content_bytes = lookup(var.quotaset_v2[count.index], "injected_file_content_bytes")
  injected_file_path_bytes    = lookup(var.quotaset_v2[count.index], "injected_file_path_bytes")
  injected_files              = lookup(var.quotaset_v2[count.index], "injected_files")
  key_pairs                   = lookup(var.quotaset_v2[count.index], "key_pairs")
  metadata_items              = lookup(var.quotaset_v2[count.index], "metadata_items")
  ram                         = lookup(var.quotaset_v2[count.index], "ram")
  security_group_rules        = lookup(var.quotaset_v2[count.index], "security_group_rules")
  security_groups             = lookup(var.quotaset_v2[count.index], "security_groups")
  server_group_members        = lookup(var.quotaset_v2[count.index], "server_group_members")
  server_groups               = lookup(var.quotaset_v2[count.index], "server_groups")
  cores                       = lookup(var.quotaset_v2[count.index], "cores")
  instances                   = lookup(var.quotaset_v2[count.index], "instances")
}

resource "openstack_compute_servergroup_v2" "this" {
  count       = length(var.servergroup_v2)
  name        = lookup(var.servergroup_v2[count.index], "name")
  region      = data.openstack_identity_project_v3.this.region
  policies    = lookup(var.servergroup_v2[count.index], "policies")
  value_specs = lookup(var.servergroup_v2[count.index], "value_specs")

  dynamic "rules" {
    for_each = lookup(var.servergroup_v2[count.index], "rules") == null ? [] : ["rules"]
    content {
      max_server_per_host = lookup(rules.value, "max_server_per_host")
    }
  }
}

resource "openstack_compute_volume_attach_v2" "this" {
  count       = length(var.volume_attach_v2) == "0" ? "0" : length(var.instance_v2)
  instance_id = try(element(openstack_compute_instance_v2.this.*.id, lookup(var.volume_attach_v2[count.index], "instance_id")))
  volume_id   = try(data.openstack_blockstorage_volume_v3.this.id)
  region      = data.openstack_identity_project_v3.this.region
  device      = lookup(var.volume_attach_v2[count.index], "device")
  multiattach = lookup(var.volume_attach_v2[count.index], "multiattach")
}
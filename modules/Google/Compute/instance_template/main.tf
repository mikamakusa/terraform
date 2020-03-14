resource "google_compute_instance_template" "instance_template" {
  count                   = length(var.instance_template)
  machine_type            = lookup(var.instance_template[count.index], "machine_type")
  project                 = lookup(var.instance_template[count.index], "project")
  provider                = "google-beta"
  region                  = lookup(var.instance_template[count.index], "region")
  can_ip_forward          = lookup(var.instance_template[count.index], "can_ip_forward")
  description             = lookup(var.instance_template[count.index], "description")
  instance_description    = lookup(var.instance_template[count.index], "instance_description")
  metadata_startup_script = lookup(var.instance_template[count.index], "metadata_startup_script")

  dynamic "labels" {
    for_each = lookup(var.instance_template[count.index], "labels")
    content {
      variables = labels.value
    }
  }

  dynamic "metadata" {
    for_each = lookup(var.instance_template[count.index], "metadata")
    content {
      variables = metadata.value
    }
  }

  dynamic "disk" {
    for_each = [for disk_info in lookup(var.instance_template[count.index], "disk") : {
      auto_delete         = disk_info.auto_delete
      source              = disk_info.source
      source_image        = disk_info.source_image
      device_name         = disk_info.device_name
      interface           = disk_info.interface
      mode                = disk_info.mode
      disk_type           = disk_info.disk_type
      disk_name           = disk_info.disk_name
      disk_size_gb        = disk_info.disk_size_gb
      type                = disk_info.type
      disk_encryption_key = lookup(disk_info, "disk_encryption_key", null)
    }]
    content {
      auto_delete  = disk.value.auto_delete
      source       = disk.value.source
      source_image = disk.value.source_image
      device_name  = disk.value.device_name
      interface    = disk.value.interface
      mode         = disk.value.mode
      disk_type    = disk.value.disk_type
      disk_name    = disk.value.disk_name
      disk_size_gb = disk.value.disk_size_gb
      type         = disk.value.type
      dynamic "disk_encryption_key" {
        for_each = disk.value.disk_encryption_key == null ? [] : [for i in disk.value.disk_encryption_key : {
          kms_key_self_link = i.kms_key_self_link
        }]
        content {
          kms_key_self_link = disk_encryption_key.value.kms_key_self_link
        }
      }
    }
  }

  dynamic "network_interface" {
    for_each = [for i in lookup(var.instance_template[count.index], "network_interface") : {
      network_ip         = i.network_ip
      access_config      = lookup(i, "access_config", null)
      alias_ip_range     = lookup(i, "alias_ip_range", null)
    }]
    content {
      network            = var.network
      network_ip         = network_interface.value.network_ip
      dynamic "access_config" {
        for_each = network_interface.value.access_config == null ? [] : [for i in network_interface.value.access_config : {
          nat_ip       = i.nat_ip
          network_tier = i.network_tier
        }]
        content {
          nat_ip       = access_config.value.nat_ip
          network_tier = access_config.value.network_tier
        }
      }
      dynamic "alias_ip_range" {
        for_each = network_interface.value.alias_ip_range == null ? [] : [for i in network_interface.value.alias_ip_range : {
          ip_cidr_range         = i.ip_cidr_range
          subnetwork_range_name = i.subnetwork_range_name
        }]
        content {
          ip_cidr_range         = alias_ip_range.value.ip_cidr_range
          subnetwork_range_name = alias_ip_range.value.subnetwork_range_name
        }
      }
    }
  }

  dynamic "service_account" {
    for_each = lookup(var.instance_template[count.index], "service_account")
    content {
      scopes = lookup(service_account.value, "scopes")
      email  = lookup(service_account.value, "email")
    }
  }

  dynamic "scheduling" {
    for_each = [for i in lookup(var.instance_template[count.index], "scheduling") : {
      automatic_restart   = i.automatic_restart
      on_host_maintenance = i.on_host_maintenance
      preemptible         = i.preemptible
      node_affinities     = lookup(i, "node_affinities", null)
    }]
    content {
      automatic_restart   = scheduling.value.automatic_restart
      on_host_maintenance = scheduling.value.on_host_maintenance
      preemptible         = scheduling.value.preemptible
      dynamic "node_affinities" {
        for_each = scheduling.value.node_affinities == null ? [] : [for i in scheduling.value.node_affinities : {
          key      = i.key
          operator = i.operator
          value    = i.value
        }]
        content {
          key      = node_affinities.value.key
          operator = node_affinities.value.operator
          values   = node_affinities.value.values
        }
      }
    }
  }

  dynamic "guest_accelerator" {
    for_each = lookup(var.instance_template[count.index], "guest_accelerator")
    content {
      count = lookup(guest_accelerator.value, "count")
      type  = lookup(guest_accelerator.value, "type")
    }
  }

  dynamic "shielded_instance_config" {
    for_each = lookup(var.instance_template[count.index], "shielded_instance_config")
    content {
      enable_integrity_monitoring = lookup(shielded_instance_config.value, "enable_integrity_monitoring")
      enable_secure_boot          = lookup(shielded_instance_config.value, "enable_secure_boot")
      enable_vtpm                 = lookup(shielded_instance_config.value, "enable_vtpm")
    }
  }
}
resource "google_compute_instance" "google_Vms" {
  count               = length(var.instance)
  name                = lookup(var.instance[count.index], "name")
  project             = var.project
  zone                = var.zone
  can_ip_forward      = lookup(var.instance[count.index], "can_ip_forward", false)
  deletion_protection = lookup(var.instance[count.index], "deletion_protection", false)
  machine_type        = lookup(var.instance[count.index], "machine_type")
  allow_stopping_for_update = lookup(var.instance[count.index], "allow_stopping_for_update", false)
  min_cpu_platform = lookup(var.instance[count.index], "min_cpu_platform", null)

  dynamic "guest_accelerator" {
    for_each = lookup(var.instance[count.index], "guest_accelerator")
    content {
      count = lookup(guest_accelerator.value, "count")
      type = lookup(guest_accelerator.value, "type")
    }
  }

  dynamic "boot_disk" {
    for_each = lookup(var.instance[count.index], "boot_disk")
    content {
      auto_delete = lookup(boot_disk.value, "auto_delete")
      device_name = lookup(boot_disk.value, "device_name")
      initialize_params {
        size  = lookup(boot_disk.value, "size")
        type  = lookup(boot_disk.value, "type")
        image = lookup(boot_disk.value, "image")
      }
    }
  }

  dynamic "network_interface" {
    for_each = lookup(var.instance[count.index], "network_interface")
    content {
      network    = lookup(network_interface.value, "network")
      subnetwork = lookup(network_interface.value, "subnetwork")
      address    = lookup(network_interface.value, "address")
    }
  }

  dynamic "attached_disk" {
    for_each = lookup(var.instance[count.index], "attached_disk")
    content {
      source                  = lookup(attached_disk.value, "source")
      device_name             = lookup(attached_disk.value, "device_name", null)
      mode                    = lookup(attached_disk.value, "mode", null)
      disk_encryption_key_raw = lookup(attached_disk.value, "disk_encryption_key_raw", null)
      kms_key_self_link       = lookup(attached_disk.value, "kms_key_self_link", null)
    }
  }

  dynamic "service_account" {
    for_each = lookup(var.instance[count.index], "service_account")
    content {
      email  = lookup(service_account.value, "email")
      scopes = [lookup(service_account.value, "scopes")]
    }
  }

  dynamic "scheduling" {
    for_each = lookup(var.instance[count.index], "scheduling")
    content {
      preemptible         = lookup(scheduling.value,"preemptible")
      on_host_maintenance = lookup(scheduling.value,"on_host_maintenance")
      automatic_restart   = lookup(scheduling.value,"automatic_restart")
      node_affinities {
        key      = lookup(scheduling.value,"key")
        operator = lookup(scheduling.value,"operator", "NOT")
        values   = [lookup(scheduling.value,"values")]
      }
    }
  }

  dynamic "shielded_instance_config" {
    for_each = lookup(var.instance[count.index], shielded_instance_config)
    content {
      enable_secure_boot = lookup(shielded_instance_config.value,"enable_secure_boot",false)
      enable_vtpm = lookup(shielded_instance_config.value,"enable_vtpm",true)
      enable_integrity_monitoring = lookup(shielded_instance_config.value,"enable_integrity_monitoring",true)
    }
  }
  metadata {
    ssh-keys = "${var.app_admin}:${var.ssh_keys}"
  }
}

data "terraform_remote_state" "" {
  backend = ""

  config {
    bucket = ""
    key = ""
  }
}

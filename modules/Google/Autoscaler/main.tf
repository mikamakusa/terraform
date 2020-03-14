resource "google_compute_autoscaler" "gcp_autoscaler" {
  count    = length(var.autoscaler)
  name     = join("-", [var.prefix, lookup(var.autoscaler[count.index], "name"), lookup(var.autoscaler[count.index], "id"), "autoscaler"])
  target   = element(google_compute_instance_group_manager.gcp_igm.*.self_link, lookup(var.autoscaler[count.index], "igm_id"))
  project  = var.project
  zone     = var.zone
  provider = "google-beta"

  dynamic "autoscaling_policy" {
    for_each = [for i in lookup(var.autoscaler[count.index], "autoscaling_policy") : {
      max_replicas               = i.max_replicas
      min_replicas               = i.min_replicas
      cooldown_period            = i.cooldown_period
      cpu_utilization            = lookup(i, "cpu_utilization", null)
      load_balancing_utilization = lookup(i, "load_balancing_utilization", null)
      metric                     = lookup(i, "metric", null)
    }]
    content {
      max_replicas    = autoscaling_policy.value.max_replicas
      min_replicas    = autoscaling_policy.value.min_replicas
      cooldown_period = autoscaling_policy.value.cooldown_period

      dynamic "cpu_utilization" {
        for_each = autoscaling_policy.value.cpu_utilization == null ? [] : [for i in autoscaling_policy.value.cpu_utilization : {
          target = i.target
        }]
        content {
          target = cpu_utilization.value.target
        }
      }

      dynamic "load_balancing_utilization" {
        for_each = autoscaling_policy.value.load_balancing_utilization == null ? [] : [for i in autoscaling_policy.value.load_balancing_utilization : {
          target = i.target
        }]
        content {
          target = load_balancing_utilization.value.target
        }
      }

      dynamic "metric" {
        for_each = autoscaling_policy.value.metric == null ? [] : [for i in autoscaling_policy.value.metric : {
          name = i.name
        }]
        content {
          name = i.name
        }
      }
    }
  }
}

resource "google_compute_instance_template" "gcp_template" {
  provider     = "google-beta"
  project      = var.project
  count        = length(var.template)
  machine_type = lookup(var.template[count.index], "machine_type")

  dynamic "disk" {
    for_each = lookup(var.template[count.index], "disk")
    content {
      source       = lookup(disk.value, "source")
      device_name  = lookup(disk.value, "device_name", null)
      disk_name    = lookup(disk.value, "disk_name", null)
      disk_size_gb = lookup(disk.value, "disk_size_gb", null)
      disk_type    = lookup(disk.value, "disk_type", null)
      auto_delete  = lookup(disk.value, "auto_delete", null)
      boot         = lookup(disk.value, "boot", null)
      interface    = lookup(disk.value, "interface", null)
      type         = lookup(disk.value, "type", null)
      disk_encryption_key {
        kms_key_self_link = element(var.kms_key_self_link, lookup(disk.value, "kms_key_id"))
      }
    }
  }

  dynamic "network_interface" {
    for_each = lookup(var.template[count.index], "network_interface")
    content {
      network            = ""
      network_ip         = ""
      subnetwork_project = ""
      subnetwork         = ""
      alias_ip_range {
        ip_cidr_range = ""
      }
      access_config {
        nat_ip       = ""
        network_tier = ""
      }
    }
  }

  dynamic "service_account" {
    for_each = lookup(var.template[count.index], "service_account")
    content {
      scopes = []
      email  = ""
    }
  }

  dynamic "shielded_instance_config" {
    for_each = lookup(var.template[count.index], "shielded_instance_config")
    content {
      enable_secure_boot          = ""
      enable_integrity_monitoring = ""
      enable_vtpm                 = ""
    }
  }

  dynamic "scheduling" {
    for_each = lookup(var.template[count.index], "scheduling")
    content {
      automatic_restart   = ""
      on_host_maintenance = ""
      preemptible         = ""
      node_affinities {
        key      = ""
        operator = ""
        values   = []
      }
    }
  }

  dynamic "guest_accelerator" {
    for_each = lookup(var.template[count.index], "guest_accelerator")
    content {
      count = 0
      type  = ""
    }
  }

  metadata = {
    ssh_keys = join("-", [lookup(var.template[count.index], "app_admin"), lookup(var.template[count.index], "ssh_key")])
  }
}

resource "google_compute_instance_group_manager" "gcp_igm" {
  count              = length(var.instance_group_manager)
  zone               = var.zone
  project            = var.project
  base_instance_name = "${var.prefix}-${lookup(var.instance_group_manager[count.index], "base_instance_name")}-${lookup(var.instance_group_manager[count.index], "id")}-instance-name"
  instance_template  = "${element(google_compute_instance_template.gcp_template.*.self_link, lookup(var.instance_group_manager[count.index], "template_id"))}"
  target_pools       = ["${element(google_compute_target_pool.gcp_target_pool.*.self_link, lookup(var.instance_group_manager[count.index], "pool_id"))}"]
  name               = "${var.prefix}-${lookup(var.instance_group_manager[count.index], "name")}-${lookup(var.instance_group_manager[count.index], "id")}-igm"
}

resource "google_compute_target_pool" "gcp_target_pool" {
  count     = length(var.pool)
  name      = "${lookup(var.pool[count.index], "name")}-pool-${lookup(var.pool[count.index], "id")}"
  instances = lookup(var.pool[count.index], "instances")
  project   = var.project
  region    = var.region
}

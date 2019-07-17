resource "google_compute_autoscaler" "gcp_autoscaler" {
  count    = length(var.autoscaler)
  name     = "${var.prefix}-${lookup(var.autoscaler[count.index], "name")}-${lookup(var.autoscaler[count.index],"id")}-autoscaler"
  target   = "${element(google_compute_instance_group_manager.gcp_igm.*.self_link,lookup(var.autoscaler[count.index],"igm_id"))}"
  project  = var.project
  zone     = var.zone
  provider = "google-beta"

  autoscaling_policy {
    max_replicas    = lookup(var.autoscaler[count.index], "max_replicas")
    min_replicas    = lookup(var.autoscaler[count.index], "min_replicas")
    cooldown_period = lookup(var.autoscaler[count.index], "cooldown_period")

    cpu_utilization {
      target = 0.5
    }

    load_balancing_utilization {
      target = 0.5
    }
  }
}

resource "google_compute_instance_template" "gcp_template" {
  provider     = "google-beta"
  project      = var.project
  count        = length(var.template)
  machine_type = lookup(var.template[count.index], "machine_type")
  disk {
    source_image = lookup(var.template[count.index], "source_image")
    auto_delete  = true
    disk_size_gb = lookup(var.template[count.index], "disk_size_gb")
    boot         = true
    disk_type    = "pd-ssd"
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
  }
  metadata = {
    ssh_keys = "${var.app_admin}:${var.ssh_key}"
  }
}

resource "google_compute_instance_group_manager" "gcp_igm" {
  count              = length(var.instance_group_manager)
  zone               = var.zone
  project            = var.project
  base_instance_name = "${var.prefix}-${lookup(var.instance_group_manager[count.index],"base_instance_name")}-${lookup(var.instance_group_manager[count.index],"id")}-instance-name"
  instance_template  = "${element(google_compute_instance_template.gcp_template.*.self_link, lookup(var.instance_group_manager[count.index], "template_id"))}"
  target_pools       = ["${element(google_compute_target_pool.gcp_target_pool.*.self_link,lookup(var.instance_group_manager[count.index],"pool_id"))}"]
  name               = "${var.prefix}-${lookup(var.instance_group_manager[count.index],"name")}-${lookup(var.instance_group_manager[count.index],"id")}-igm"
}

resource "google_compute_target_pool" "gcp_target_pool" {
  count     = length(var.pool)
  name      = "${lookup(var.pool[count.index], "name")}-pool-${lookup(var.pool[count.index], "id")}"
  instances = lookup(var.pool[count.index], "instances")
  project   = var.project
  region    = var.region
}

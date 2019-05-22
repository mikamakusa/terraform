resource "google_compute_instance" "" {
  count        = ""
  name         = ""
  machine_type = ""
  zone         = ""
  tags         = []

  boot_disk {
    initialize_params {
      image = ""
      size  = ""
    }
  }

  "network_interface" {
    network            = ""
    subnetwork         = ""
    subnetwork_project = ""
    address            = ""

    access_config {
      nat_ip                 = ""
      public_ptr_domain_name = ""
      network_tier           = ""
    }
  }

  attached_disk {
    source                  = ""
    device_name             = ""
    mode                    = ""
    disk_encryption_key_raw = ""
  }

  service_account {
    scopes = []
    email  = ""
  }

  scheduling {
    preemptible         = ""
    on_host_maintenance = ""
    automatic_restart   = ""
  }
}

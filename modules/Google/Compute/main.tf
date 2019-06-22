resource "google_compute_address" "gcp_address" {
  count        = "${length(var.address)}"
  name         = "${var.prefix}-${lookup(var.address[count.index],"suffix_name")}-${lookup(var.address[count.index],"id")}-addr"
  region       = "${var.region}"
  project      = "${var.project}"
  subnetwork   = "${var.subnetwork}"
  address_type = "${lookup(var.address[count.index],"address_type")}"
  address      = "${lookup(var.address[count.index],"address")}"
}

resource "google_compute_disk" "gcp_disk" {
  count = "${length(var.disk)}"
  name  = "${lookup(var.disk[count.index],"name")}"
  type  = "${lookup(var.disk[count.index],"type")}"
  zone  = "${var.zone}"
  size  = "${lookup(var.disk[count.index],"size")}"
}

resource "google_compute_attached_disk" "gcp_attached_disk" {
  count       = "${length(var.disk)}"
  disk        = "${element(google_compute_disk.gcp_disk.*.self_link,count.index)}"
  instance    = "${element(google_compute_instance.google_Vms.*.id,lookup(var.disk[count.index],"instance_id"))}"
  device_name = "${lookup(var.disk[count.index],"device_name")}"
  project     = "${var.project}"
  zone        = "${var.zone}"
}

resource "google_compute_instance" "google_Vms" {
  count               = "${length(var.Linux_Vms)}"
  name                = "${var.prefix}-${lookup(var.Linux_Vms[count.index],"suffix_name")}-${lookup(var.Linux_Vms[count.index], "id")}"
  project             = "${var.project}"
  zone                = "projects/${var.app_project}/zones/${var.zone}"
  can_ip_forward      = "${lookup(var.Linux_Vms[count.index],"can_ip_forward")}"
  deletion_protection = "${lookup(var.Linux_Vms[count.index],"deletion_protection")}"
  machine_type        = "${lookup(var.Linux_Vms[count.index],"machine_type")}"

  "boot_disk" {
    auto_delete = "${lookup(var.Linux_Vms[count.index],"auto_delete")}"
    device_name = "${var.prefix}-${lookup(var.Linux_Vms[count.index],"suffix_name")}-${lookup(var.Linux_Vms[count.index], "id")}-bootdisk"

    initialize_params {
      size  = "${lookup(var.Linux_Vms[count.index],"size")}"
      type  = "${lookup(var.Linux_Vms[count.index],"type")}"
      image = "${lookup(var.Linux_Vms[count.index],"image")}"
    }
  }

  "network_interface" {
    network    = "${var.network}"
    subnetwork = "${var.subnetwork}"
    address    = "${element(google_compute_address.gcp_address.*.id,lookup(var.Linux_Vms[count.index],"address_id"))}"
  }

  metadata {
    ssh-keys = "${var.app_admin}:${var.ssh_keys}"
  }
}

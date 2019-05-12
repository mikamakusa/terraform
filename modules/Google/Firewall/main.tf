resource "google_compute_firewall" "gc_firewall_allow" {
  count         = "${length(var.firewall_allow ? 1 : 0)}"
  name          = "${lookup(var.firewall_allow[count.index],"name")}"
  network       = "${var.network}"
  source_ranges = ["${lookup(var.firewall_allow[count.index],"source_ranges")}"]
  project       = "${var.project}"
  priority      = "${lookup(var.firewall_allow[count.index],"priority")}"

  allow {
    protocol = "${lookup(var.firewall_allow[count.index],"protocol")}"
    ports    = ["${lookup(var.firewall_allow[count.index],"ports")}"]
  }
}

resource "google_compute_firewall" "gc_firewall_deny" {
  count         = "${length(var.firewall_deny ? 1 : 0)}"
  name          = "${lookup(var.firewall_deny[count.index],"name")}"
  network       = "${var.network}"
  source_ranges = ["${lookup(var.firewall_deny[count.index],"source_ranges")}"]
  project       = "${var.project}"
  priority      = "${lookup(var.firewall_deny[count.index],"priority")}"

  deny {
    protocol = "${lookup(var.firewall_deny[count.index],"protocol")}"
    ports    = ["${lookup(var.firewall_deny[count.index],"ports" )}"]
  }
}


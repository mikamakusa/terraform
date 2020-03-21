resource "google_compute_firewall" "gc_firewall_allow" {
  count         = length(var.firewall_allow)
  name          = lookup(var.firewall_allow[count.index],"name")
  network       = var.network
  source_ranges = lookup(var.firewall_allow[count.index],"source_ranges")
  project       = var.project
  priority      = lookup(var.firewall_allow[count.index],"priority")

  dynamic "allow" {
    for_each = lookup(var.firewall_allow, )
    content {
      protocol = lookup(allow.value, "protocol")
      ports = lookup(allow.value, "ports")
    }
  }
}

resource "google_compute_firewall" "gc_firewall_deny" {
  count         = length(var.firewall_deny)
  name          = lookup(var.firewall_deny[count.index],"name")
  network       = var.network
  source_ranges = lookup(var.firewall_deny[count.index],"source_ranges")
  project       = var.project
  priority      = lookup(var.firewall_deny[count.index],"priority")

  dynamic "deny" {
    for_each = lookup(var.firewall_deny[count.index], "deny")
    content {
      protocol = lookup(deny.value, "protocol")
      ports = lookup(deny.value, "ports")
    }
  }
}


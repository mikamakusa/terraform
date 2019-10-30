resource "google_bigtable_instance" "ggl_bt_instance" {
  count         = length(var.bt_instance)
  name          = lookup(var.bt_instance[count.index], "name")
  project       = lookup(var.bt_instance[count.index], "project", null)
  instance_type = lookup(var.bt_instance[count.index], "instance_type", null)
  display_name  = lookup(var.bt_instance[count.index], "display_name", null)

  dynamic "cluster" {
    for_each = lookup(var.bt_instance[count.index], "cluster")
    content {
      cluster_id   = lookup(cluster.value, "cluster_id")
      zone         = lookup(cluster.value, "zone")
      num_nodes    = lookup(cluster.value, "num_nodes", null)
      storage_type = lookup(cluster.value, "storage_type", null)
    }
  }
}

resource "google_bigtable_table" "ggl_bt_table" {
  count         = "${"${length(var.bt_instance)}" == "0" ? "0" : "${length(var.bt_table)}"}"
  instance_name = element(google_bigtable_instance.ggl_bt_instance.*.name, lookup(var.bt_table[count.index], "instance_name"))
  name          = lookup(var.bt_table[count.index], "name")
  split_keys    = [lookup(var.bt_table[count.index], "split_keys", null)]
  project       = lookup(var.bt_table[count.index], "project", null)

  dynamic "column_family" {
    for_each = lookup(var.bt_table[count.index], "column_family")
    content {
      family = lookup(column_family.value, "family", null)
    }
  }
}

resource "google_bigtable_app_profile" "bt_app_profile" {
  count                         = length(var.app_profile) ? 1 : 0
  app_profile_id                = lookup(var.app_profile[count.index], "app_profile_id")
  multi_cluster_routing_use_any = lookup(var.app_profile[count.index], "multi_cluster_routing_use_any", null)
  instance                      = lookup(var.app_profile[count.index], "instance", null)
  ignore_warnings               = lookup(var.app_profile[count.index], "ignore_warnings", null)
  project                       = lookup(var.app_profile[count.index], "project", null)

  dynamic "single_cluster_routing" {
    for_each = lookup(var.app_profile[count.index], "single_cluster_routing")
    content {
      cluster_id                 = lookup(single_cluster_routing.value, "cluster_id", null)
      allow_transactional_writes = lookup(single_cluster_routing.value, "allow_transactional_writes", null)
    }
  }
}

resource "google_bigtable_gc_policy" "bt_gc_policy" {
  count         = length(var.bt_policy) ? 1 : 0
  column_family = lookup(var.bt_policy[count.index], "column_family")
  instance_name = element(google_bigtable_instance.ggl_bt_instance.*.name, lookup(var.bt_policy[count.index], "instance_name"))
  table         = element(google_bigtable_table.ggl_bt_table.*.name,lookup(var.bt_policy[count.index],"table_name"))
  project       = lookup(var.bt_policy[count.index], "project", null)
  mode          = lookup(var.bt_policy[count.index], "mode", null)

  dynamic "max_age" {
    for_each = lookup(var.bt_policy[count.index], "max_age")
    content {
      days = lookup(max_age.value, "days", null)
    }
  }

  dynamic "max_version" {
    for_each = lookup(var.bt_policy[count.index], "max_version")
    content {
      number = lookup(max_version.value, "number", null)
    }
  }
}
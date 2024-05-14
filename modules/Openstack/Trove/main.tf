resource "openstack_db_configuration_v1" "this" {
  count       = length(var.configuration_v1)
  description = lookup(var.configuration_v1[count.index], "description")
  name        = lookup(var.configuration_v1[count.index], "name")
  region      = data.openstack_identity_project_v3.this.region

  dynamic "datastore" {
    for_each = lookup(var.configuration_v1[count.index], "datastore")
    content {
      type    = lookup(datastore.value, "type")
      version = lookup(datastore.value, "version")
    }
  }

  dynamic "configuration" {
    for_each = lookup(var.configuration_v1[count.index], "configuration") == null ? [] : ["configuration"]
    content {
      name        = lookup(configuration.value, "name")
      value       = lookup(configuration.value, "value")
      string_type = lookup(configuration.value, "string_type")
    }
  }
}

resource "openstack_db_database_v1" "this" {
  count       = length(var.database_v1) == "0" ? "0" : length(var.instance_v1)
  instance_id = try(element(openstack_db_instance_v1.this.*.id, lookup(var.database_v1[count.index], "instance_id")))
  name        = lookup(var.database_v1[count.index], "name")
}

resource "openstack_db_instance_v1" "this" {
  count            = length(var.instance_v1)
  name             = lookup(var.instance_v1[count.index], "name")
  size             = lookup(var.instance_v1[count.index], "size")
  region           = data.openstack_identity_project_v3.this.region
  configuration_id = try(element(openstack_db_configuration_v1.this.*.id, lookup(var.instance_v1[count.index], "configuration_id")))

  dynamic "datastore" {
    for_each = lookup(var.instance_v1[count.index], "datastore")
    content {
      type    = lookup(datastore.value, "type")
      version = lookup(datastore.value, "version")
    }
  }

  dynamic "network" {
    for_each = lookup(var.instance_v1[count.index], "network") == null ? [] : ["network"]
    content {
      uuid        = lookup(network.value, "uuid")
      port        = lookup(network.value, "port")
      fixed_ip_v4 = lookup(network.value, "fixed_ip_v4")
      fixed_ip_v6 = lookup(network.value, "fixed_ip_v6")
    }
  }

  dynamic "user" {
    for_each = lookup(var.instance_v1[count.index], "user") == null ? [] : ["user"]
    content {
      name      = lookup(user.value, "name")
      password  = sensitive(lookup(user.value, "password"))
      host      = lookup(user.value, "host")
      databases = lookup(user.value, "databases")
    }
  }

  dynamic "database" {
    for_each = lookup(var.instance_v1[count.index], "database") == null ? [] : ["database"]
    content {
      name    = lookup(database.value, "name")
      collate = lookup(database.value, "collate")
      charset = lookup(database.value, "charset")
    }
  }
}

resource "openstack_db_user_v1" "this" {
  count       = length(var.user_v1) == "0" ? "0" : length(var.instance_v1)
  instance_id = try(element(openstack_db_instance_v1.this.*.id, lookup(var.user_v1[count.index], "instance_id")))
  name        = lookup(var.user_v1[count.index], "name")
  password    = sensitive(lookup(var.user_v1[count.index], "password"))
  databases   = lookup(var.user_v1[count.index], "databases")
}
resource "openstack_db_instance_v1" "os_db_instance" {
  depends_on       = ["openstack_db_configuration_v1.os_db_config", "openstack_db_user_v1.os_db_user"]
  count            = "${length(var.os_db)}"
  region           = "${var.region}"
  name             = "${lookup(var.os_db[count.index], "name")}-db"
  flavor_id        = "${lookup(var.os_db[count.index], "flavor")}"
  size             = "${lookup(var.os_db[count.index], "size")}"
  configuration_id = "${element(openstack_db_configuration_v1.os_db_config.*.id,lookup(var.os_db[count.index],"config_id"))}"

  user {
    name      = "${element(openstack_db_user_v1.os_db_user.*.name,lookup(var.os_db[count.index],"username"))}"
    password  = "${element(openstack_db_user_v1.os_db_user.*.password,lookup(var.os_db[count.index],"password"))}"
    host      = "${element(var.users,lookup(var.os_db[count.index],"host"))}"
    databases = ["${element(var.databases,lookup(var.os_db[count.index],"databases"))}"]
  }

  network {
    uuid        = "${element(var.network_id,lookup(var.os_db[count.index], "network_id"))}"
    port        = "${lookup(var.os_db[count.index], "port")}"
    fixed_ip_v4 = "${element(var.fixed_ip,lookup(var.os_db[count.index], "fixed_ip"))}"
  }

  "datastore" {
    type    = "${lookup(var.os_db[count.index],"datastore_type")}"
    version = "${lookup(var.os_db[count.index],"version")}"
  }

  database {
    name    = "${lookup(var.os_db[count.index], "db_name")}"
    charset = "${lookup(var.os_db[count.index], "db_charset")}"
    collate = "${lookup(var.os_db[count.index], "db_collate")}"
  }
}

resource "openstack_db_database_v1" "os_db_database" {
  depends_on  = ["openstack_db_instance_v1.os_db_instance"]
  instance_id = "${element(openstack_db_instance_v1.os_db_instance.id,lookup(var.os_db[count.index],"instance_id"))}"
  name        = "${element(openstack_db_instance_v1.os_db_instance.database.name,lookup(var.os_db[count.index],"db_name"))}"
}

resource "openstack_db_configuration_v1" "os_db_config" {
  count       = "${length(var.db_config)}"
  name        = "${lookup(var.db_config[count.index],"name")}"
  region      = "${var.region}"
  description = "${lookup(var.db_config[count.index],"description")}"

  "datastore" {
    type    = "${element(openstack_db_instance_v1.os_db_instance.*.datastore.type,lookup(var.os_db,"datastore_type"))}"
    version = "${element(openstack_db_instance_v1.os_db_instance.*.datastore.type,lookup(var.os_db,"version"))}"
  }

  configuration {
    name  = "${lookup(var.db_config[count.index],"config_name")}"
    value = "${lookup(var.db_config[count.index],"config_value")}"
  }
}

resource "openstack_db_user_v1" "os_db_user" {
  count       = "${length(var.users)}"
  instance_id = "${element(openstack_db_instance_v1.os_db_instance.*.id,lookup(var.users[count.index],"instance_id"))}"
  name        = "${lookup(var.users[count.index],"username")}"
  password    = "${lookup(var.users[count.index],"password")}"
  host        = "${lookup(var.users[count.index],"host")}"
}

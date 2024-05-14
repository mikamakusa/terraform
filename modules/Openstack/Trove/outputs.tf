output "instance" {
  value = try(
    openstack_db_instance_v1.this.*.id,
    openstack_db_instance_v1.this.*.name
  )
}

output "configuration" {
  value = try(
    openstack_db_configuration_v1.this.*.name,
    openstack_db_configuration_v1.this.*.id
  )
}

output "user" {
  value = try(
    openstack_db_user_v1.this.*.id,
    openstack_db_user_v1.this.*.name
  )
}

output "database" {
  value = try(
    openstack_db_database_v1.this.*.name,
    openstack_db_database_v1.this.*.id
  )
}
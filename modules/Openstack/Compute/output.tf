output "flavor" {
  value = try(openstack_compute_flavor_v2.flavor)
}

output "flavor_access" {
  value = try(openstack_compute_flavor_access_v2.flavor_access)
}

output "instance" {
  value = try(openstack_compute_instance_v2.instance)
}

output "floatingip" {
  value = try(openstack_compute_floatingip_v2.this)
}
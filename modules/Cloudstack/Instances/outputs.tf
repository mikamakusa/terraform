output "instance_id" {
  value = cloudstack_instance.instances.*.id
}

output "instance_name" {
  value = cloudstack_instance.instances.*.name
}
output "resource_group" {
  value = try(
    data.ibm_resource_group.this,
    ibm_resource_group.this
  )
}

output "resource_instance" {
  value = try(
    data.ibm_resource_instance.this,
    ibm_resource_instance.this
  )
}

output "resource_key" {
  value = try(
    ibm_resource_key.this
  )
}
data "ibm_resource_group" "this" {
  count = var.resource_group_name ? 1 : 0
  name  = var.resource_group_name
}

data "ibm_resource_instance" "this" {
  count             = var.resource_instance_name ? 1 : 0
  name              = var.resource_instance_name
  resource_group_id = data.ibm_resource_group.this.id
}
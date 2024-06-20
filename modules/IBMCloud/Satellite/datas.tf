data "ibm_resource_group" "this" {
  count = var.resource_group_name ? 1 : 0
  name  = var.resource_group_name
}

data "ibm_cos_bucket" "this" {
  count                = var.cos_bucket ? 1 : 0
  bucket_name          = var.cos_bucket
  resource_instance_id = data.ibm_resource_group.this.id
}
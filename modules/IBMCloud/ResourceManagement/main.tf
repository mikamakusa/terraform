resource "ibm_resource_group" "this" {
  count = length(var.resource_group)
  name  = lookup(var.resource_group[count.index], "name")
  tags  = lookup(var.resource_group[count.index], "tags")
}

resource "ibm_resource_instance" "this" {
  count           = length(var.resource_instance) == "0" ? "0" : (length(var.resource_group) || data.ibm_resource_group)
  location        = lookup(var.resource_instance[count.index], "location")
  name            = lookup(var.resource_instance[count.index], "name")
  plan            = lookup(var.resource_instance[count.index], "plan")
  service         = lookup(var.resource_instance[count.index], "service")
  parameters      = lookup(var.resource_instance[count.index], "parameters")
  parameters_json = lookup(var.resource_instance[count.index], "parameters_json")
  resource_group_id = try(
    data.ibm_resource_group.this.id,
    element(ibm_resource_group.this.*.id, lookup(var.resource_instance[count.index], "resource_group_id"))
  )
  tags              = lookup(var.resource_instance[count.index], "tags")
  service_endpoints = lookup(var.resource_instance[count.index], "service_endpoints")
}

resource "ibm_resource_key" "this" {
  count      = length(var.resource_key) == "0" ? "0" : (length(var.resource_instance) || data.ibm_resource_instance)
  name       = lookup(var.resource_key[count.index], "name")
  parameters = lookup(var.resource_key[count.index], "parameters")
  role       = lookup(var.resource_key[count.index], "role")
  resource_instance_id = try(
    data.ibm_resource_instance.this.id,
    element(ibm_resource_instance.this.*.id, lookup(var.resource_key[count.index], "resource_instance_id"))
  )
  resource_alias_id = lookup(var.resource_key[count.index], "resource_alias_id")
  tags              = lookup(var.resource_key[count.index], "tags")
}


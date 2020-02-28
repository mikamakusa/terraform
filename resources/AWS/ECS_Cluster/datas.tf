data "template_file" "container_definitions" {
  count    = length(var.container_definitions)
  template = file(join(".", [join("/", [path.cwd, "container", lookup(var.container_definitions[count.index], "container_definition")]), "json"]))

  vars = {
    cpu           = lookup(var.container_definitions[count.index], "cpu")
    memory        = lookup(var.container_definitions[count.index], "memory")
    image         = lookup(var.container_definitions[count.index], "image")
    name          = lookup(var.container_definitions[count.index], "name")
    networkMode   = lookup(var.container_definitions[count.index], "network_mode")
    containerPort = lookup(var.container_definitions[count.index], "containerPort")
    hostPort      = lookup(var.container_definitions[count.index], "hostPort")
  }
}
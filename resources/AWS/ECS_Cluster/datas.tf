data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.bucket
    key    = "vpc.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"

  config = {
    bucket = var.bucket
    key    = "iam.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "lb" {
  backend = "s3"

  config = {
    bucket = var.bucket
    key    = "lb.tfstate"
    region = var.region
  }
}



data "template_file" "container_definitions" {
  count    = length(var.container_definitions)
  template = file(join(".", [join("/", [path.cwd, "container", lookup(var.container_definitions[count.index], "container_definition")]), "json"]))

  vars = {
    region        = var.region
    cpu           = lookup(var.container_definitions[count.index], "cpu")
    memory        = lookup(var.container_definitions[count.index], "memory")
    image         = lookup(var.container_definitions[count.index], "image")
    name          = lookup(var.container_definitions[count.index], "name")
    networkMode   = lookup(var.container_definitions[count.index], "network_mode")
    containerPort = lookup(var.container_definitions[count.index], "containerPort")
    hostPort      = lookup(var.container_definitions[count.index], "hostPort")
  }
}
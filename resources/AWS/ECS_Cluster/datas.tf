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

data "terraform_remote_state" "logs" {
  backend = "s3"

  config = {
    bucket = var.bucket
    key    = "cloudwatch.tfstate"
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

resource "local_file" "container_definition" {
  count    = length(var.definition)
  filename = "${path.cwd}/container/${lookup(var.definition[count.index], "name")}.json"
  content  = <<JSON
[
  {
    "command": %{if lookup(var.definition[count.index], "command") == "" }null,%{else}${jsonencode(lookup(var.definition[count.index], "command"))}%{endif},
    "cpu": ${jsonencode(lookup(var.definition[count.index], "cpu"))},
    "disableNetworking": ${jsonencode(lookup(var.definition[count.index], "disableNetworking"))},
    "dnsSearchDomains": %{if lookup(var.definition[count.index], "dnsSearchDomains") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "dnsSearchDomains"))}%{endif},
    "dnsServers": %{if lookup(var.definition[count.index], "dnsServers") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "dnsServers"))}%{endif},
    "dockerLabels": %{if lookup(var.definition[count.index], "dockerLabels") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "dockerLabels"))}%{endif},
    "dockerSecurityOptions": %{if lookup(var.definition[count.index], "dockerSecurityOptions") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "dockerSecurityOptions"))}%{endif},
    "entryPoint": %{if lookup(var.definition[count.index], "entryPoint") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "entryPoint"))}%{endif},
    "environment": %{if lookup(var.definition[count.index], "environment") == ""}[]%{else}${jsonencode(lookup(var.definition[count.index], "environment"))}%{endif},
    "essential": ${jsonencode(lookup(var.definition[count.index], "essential"))},
    "extraHosts": %{if lookup(var.definition[count.index], "extraHosts") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "extraHosts"))}%{endif},
    "healthCheck": %{if lookup(var.definition[count.index], "healthCheck") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "healthCheck"))}%{endif},
    "hostname": %{if lookup(var.definition[count.index], "hostname") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "hostname"))}%{endif},
    "image": ${jsonencode(lookup(var.definition[count.index], "image"))},
    "interactive": %{if lookup(var.definition[count.index], "interactive") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "interactive"))}%{endif},
    "links": %{if lookup(var.definition[count.index], "links") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "links"))}%{endif},
    "linuxParameters": %{if lookup(var.definition[count.index], "linuxParameters") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "linuxParameters"))}%{endif},
    "logConfiguration": %{if lookup(var.definition[count.index], "logConfiguration") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "logConfiguration"))}%{endif},
    "memory": ${jsonencode(lookup(var.definition[count.index], "memory"))},
    "memoryReservation": %{if lookup(var.definition[count.index], "memoryReservation") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "memoryReservation"))}%{endif},
    "mountPoints": %{if lookup(var.definition[count.index], "mountPoints") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "mountPoints"))}%{endif},
    "name": ${jsonencode(lookup(var.definition[count.index], "name"))},
    "portMappings": %{if lookup(var.definition[count.index], "portMappings") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "portMappings"))}%{endif},
    "privileged": false,
    "pseudoTerminal": %{if lookup(var.definition[count.index], "pseudoTerminal") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "pseudoTerminal"))}%{endif},
    "readonlyRootFilesystem": %{if lookup(var.definition[count.index], "readonlyRootFilesystem") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "readonlyRootFilesystem"))}%{endif},
    "secrets": %{if lookup(var.definition[count.index], "secrets") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "secrets"))}%{endif},
    "systemControls": %{if lookup(var.definition[count.index], "systemControls") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "systemControls"))}%{endif},
    "ulimits": %{if lookup(var.definition[count.index], "ulimits") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "ulimits"))}%{endif},
    "user": %{if lookup(var.definition[count.index], "user") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "user"))}%{endif},
    "volumesFrom": %{if lookup(var.definition[count.index], "volumesFrom") == ""}[]%{else}${jsonencode(lookup(var.definition[count.index], "volumesFrom"))}%{endif},
    "workingDirectory": %{if lookup(var.definition[count.index], "workingDirectory") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "workingDirectory"))}%{endif},
    "dependsOn": %{if lookup(var.definition[count.index], "dependsOn") == ""}null%{else}${jsonencode(lookup(var.definition[count.index], "dependsOn"))}%{endif}
  }
]
JSON
}

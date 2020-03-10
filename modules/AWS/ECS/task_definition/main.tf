resource "local_file" "container_definition" {
  count    = length(var.container_definitions)
  filename = "${path.cwd}/container/${lookup(var.container_definitions[count.index], "name")}.json"
  content  = <<JSON
[
  {
    "command": %{if lookup(var.container_definitions[count.index], "command") == ""}null,%{else}${jsonencode(lookup(var.container_definitions[count.index], "command"))}%{endif},
    "cpu": ${jsonencode(lookup(var.container_definitions[count.index], "cpu"))},
    "disableNetworking": ${jsonencode(lookup(var.container_definitions[count.index], "disableNetworking"))},
    "dnsSearchDomains": %{if lookup(var.container_definitions[count.index], "dnsSearchDomains") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "dnsSearchDomains"))}%{endif},
    "dnsServers": %{if lookup(var.container_definitions[count.index], "dnsServers") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "dnsServers"))}%{endif},
    "dockerLabels": %{if lookup(var.container_definitions[count.index], "dockerLabels") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "dockerLabels"))}%{endif},
    "dockerSecurityOptions": %{if lookup(var.container_definitions[count.index], "dockerSecurityOptions") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "dockerSecurityOptions"))}%{endif},
    "entryPoint": %{if lookup(var.container_definitions[count.index], "entryPoint") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "entryPoint"))}%{endif},
    "environment": %{if lookup(var.container_definitions[count.index], "environment") == ""}[]%{else}${jsonencode(lookup(var.container_definitions[count.index], "environment"))}%{endif},
    "essential": ${jsonencode(lookup(var.container_definitions[count.index], "essential"))},
    "extraHosts": %{if lookup(var.container_definitions[count.index], "extraHosts") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "extraHosts"))}%{endif},
    "healthCheck": %{if lookup(var.container_definitions[count.index], "healthCheck") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "healthCheck"))}%{endif},
    "hostname": %{if lookup(var.container_definitions[count.index], "hostname") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "hostname"))}%{endif},
    "image": ${jsonencode(lookup(var.container_definitions[count.index], "image"))},
    "interactive": %{if lookup(var.container_definitions[count.index], "interactive") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "interactive"))}%{endif},
    "links": %{if lookup(var.container_definitions[count.index], "links") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "links"))}%{endif},
    "linuxParameters": %{if lookup(var.container_definitions[count.index], "linuxParameters") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "linuxParameters"))}%{endif},
    "logConfiguration": %{if lookup(var.container_definitions[count.index], "logConfiguration") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "logConfiguration"))}%{endif},
    "memory": ${jsonencode(lookup(var.container_definitions[count.index], "memory"))},
    "memoryReservation": %{if lookup(var.container_definitions[count.index], "memoryReservation") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "memoryReservation"))}%{endif},
    "mountPoints": %{if lookup(var.container_definitions[count.index], "mountPoints") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "mountPoints"))}%{endif},
    "name": ${jsonencode(lookup(var.container_definitions[count.index], "name"))},
    "portMappings": %{if lookup(var.container_definitions[count.index], "portMappings") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "portMappings"))}%{endif},
    "privileged": false,
    "pseudoTerminal": %{if lookup(var.container_definitions[count.index], "pseudoTerminal") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "pseudoTerminal"))}%{endif},
    "readonlyRootFilesystem": %{if lookup(var.container_definitions[count.index], "readonlyRootFilesystem") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "readonlyRootFilesystem"))}%{endif},
    "secrets": %{if lookup(var.container_definitions[count.index], "secrets") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "secrets"))}%{endif},
    "systemControls": %{if lookup(var.container_definitions[count.index], "systemControls") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "systemControls"))}%{endif},
    "ulimits": %{if lookup(var.container_definitions[count.index], "ulimits") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "ulimits"))}%{endif},
    "user": %{if lookup(var.container_definitions[count.index], "user") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "user"))}%{endif},
    "volumesFrom": %{if lookup(var.container_definitions[count.index], "volumesFrom") == ""}[]%{else}${jsonencode(lookup(var.container_definitions[count.index], "volumesFrom"))}%{endif},
    "workingDirectory": %{if lookup(var.container_definitions[count.index], "workingDirectory") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "workingDirectory"))}%{endif},
    "dependsOn": %{if lookup(var.container_definitions[count.index], "dependsOn") == ""}null%{else}${jsonencode(lookup(var.container_definitions[count.index], "dependsOn"))}%{endif}
  }
]
JSON
}

resource "aws_ecs_task_definition" "task_definition" {
  count                    = length(var.task_definition)
  container_definitions    = file(join(".", [join("/", [path.cwd, "container", lookup(var.task_definition[count.index], "container_definitions")]), "json"]))
  family                   = lookup(var.task_definition[count.index], "family")
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.execution_role_arn
  network_mode             = lookup(var.task_definition[count.index], "network_mode")
  ipc_mode                 = lookup(var.task_definition[count.index], "ipc_mode", null)
  pid_mode                 = lookup(var.task_definition[count.index], "pid_mode", null)
  cpu                      = lookup(var.task_definition[count.index], "cpu", 256)
  memory                   = lookup(var.task_definition[count.index], "memory", 512)
  requires_compatibilities = [lookup(var.task_definition[count.index], "requires_compatibilities")]

  dynamic "volume" {
    for_each = [for i in lookup(var.task_definition[count.index], "volume") : {
      name                        = i.name
      host_path                   = i.host_path
      docker_volume_configuration = lookup(i, "docker_volume_configuration", null)
      efs_volume_configuration    = lookup(i, "efs_volume_configuration", null)
    }]
    content {
      name      = volume.value.name
      host_path = volume.value.host_path
      dynamic "docker_volume_configuration" {
        for_each = volume.value.docker_volume_configuration == null ? [] : [for i in volume.value.docker_volume_configuration : {
          scope         = i.scope
          autoprovision = i.autoprovision
          driver        = i.driver
          driver_opts   = i.driver_opts
          labels        = i.labels
        }]
        content {
          scope         = docker_volume_configuration.value.scope
          autoprovision = docker_volume_configuration.value.autoprovision
          driver        = docker_volume_configuration.value.driver
          driver_opts = {
            variables = docker_volume_configuration.value.driver_opts
          }
          labels = {
            variables = docker_volume_configuration.value.labels
          }
        }
      }
      dynamic "efs_volume_configuration" {
        for_each = volume.value.efs_volume_configuration == null ? [] : [for i in volume.value.efs_volume_configuration : {
          file_system_id = i.file_system_id
          root_directory = i.root_directory
        }]
        content {
          file_system_id = efs_volume_configuration.value.file_system_id == "" ? var.file_system_id : efs_volume_configuration.value.file_system_id
          root_directory = efs_volume_configuration.value.root_directory
        }
      }
    }
  }

  dynamic "placement_constraints" {
    for_each = lookup(var.task_definition[count.index], "placement_constraints")
    content {
      type       = lookup(placement_constraints.value, "type")
      expression = lookup(placement_constraints.value, "expression")
    }
  }

  dynamic "proxy_configuration" {
    for_each = [for i in lookup(var.task_definition[count.index], "proxy_configuration") : {
      container_name = i.container_name
      type           = i.type
      properties     = lookup(i, "properties", null)
    }]
    content {
      container_name = proxy_configuration.value.container_name
      type           = proxy_configuration.value.type
      properties = {
        variables = proxy_configuration.value.properties
      }
    }
  }

  tags = var.tags
}
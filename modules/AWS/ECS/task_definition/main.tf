resource "aws_ecs_task_definition" "task_definition" {
  count                    = length(var.task_definition)
  container_definitions    = element(var.container_definitions, lookup(var.task_definition[count.index], "container_definition_id"))
  family                   = lookup(var.task_definition[count.index], "family")
  task_role_arn            = element(var.task_role_arn, lookup(var.task_definition[count.index], "task_role_id"))
  execution_role_arn       = element(var.execution_role_arn, lookup(var.task_definition[count.index], "execution_role_id"))
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
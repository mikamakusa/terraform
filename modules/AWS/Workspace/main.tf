resource "aws_workspaces_directory" "this" {
  count        = length(var.directory)
  directory_id = data.aws_directory_service_directory.this.id
  subnet_ids   = lookup(var.directory[count.index], "subnet_ids")
  tags = merge(
    var.tags,
    lookup(var.directory[count.index], "tags")
  )

  dynamic "self_service_permissions" {
    for_each = lookup(var.directory[count.index], "self_service_permissions") == null ? [] : ["self_service_permissions"]
    content {
      change_compute_type  = lookup(self_service_permissions.value, "change_compute_type")
      increase_volume_size = lookup(self_service_permissions.value, "increase_volume_size")
      rebuild_workspace    = lookup(self_service_permissions.value, "rebuild_workspace")
      restart_workspace    = lookup(self_service_permissions.value, "restart_workspace")
      switch_running_mode  = lookup(self_service_permissions.value, "switch_running_mode")
    }
  }

  dynamic "workspace_access_properties" {
    for_each = lookup(var.directory[count.index], "workspace_access_properties") == null ? [] : ["workspace_access_properties"]
    content {
      device_type_android    = lookup(workspace_access_properties.value, "device_type_android")
      device_type_chromeos   = lookup(workspace_access_properties.value, "device_type_chromeos")
      device_type_ios        = lookup(workspace_access_properties.value, "device_type_ios")
      device_type_osx        = lookup(workspace_access_properties.value, "device_type_osx")
      device_type_web        = lookup(workspace_access_properties.value, "device_type_web")
      device_type_windows    = lookup(workspace_access_properties.value, "device_type_windows")
      device_type_zeroclient = lookup(workspace_access_properties.value, "device_type_zeroclient")
    }
  }

  dynamic "workspace_creation_properties" {
    for_each = lookup(var.directory[count.index], "workspace_creation_properties") == null ? [] : ["workspace_creation_properties"]
    content {
      custom_security_group_id            = lookup(workspace_creation_properties.value, "custom_security_group_id")
      default_ou                          = lookup(workspace_creation_properties.value, "default_ou")
      enable_internet_access              = lookup(workspace_creation_properties.value, "enable_internet_access")
      enable_maintenance_mode             = lookup(workspace_creation_properties.value, "enable_maintenance_mode")
      user_enabled_as_local_administrator = lookup(workspace_creation_properties.value, "user_enabled_as_local_administrator")
    }
  }
}

resource "aws_workspaces_ip_group" "this" {
  count       = length(var.ip_group)
  name        = lookup(var.ip_group[count.index], "name")
  description = lookup(var.ip_group[count.index], "description")
  tags = merge(
    var.tags,
    lookup(var.ip_group[count.index], "tags")
  )

  dynamic "rules" {
    for_each = lookup(var.ip_group[count.index], "rules") == null ? [] : ["rules"]
    content {
      source      = lookup(rules.value, "source")
      description = lookup(rules.value, "description")
    }
  }
}

resource "aws_workspaces_workspace" "this" {
  count     = length(var.workspace) == "0" ? "0" : length(var.directory)
  bundle_id = lookup(var.workspace[count.index], "bundle_id")
  directory_id = try(
    element(aws_workspaces_directory.this.*.id, lookup(var.workspace[count.index], "directory_id"))
  )
  user_name                      = lookup(var.workspace[count.index], "user_name")
  root_volume_encryption_enabled = lookup(var.workspace[count.index], "root_volume_encryption_enabled")
  user_volume_encryption_enabled = lookup(var.workspace[count.index], "user_volume_encryption_enabled")
  volume_encryption_key          = lookup(var.workspace[count.index], "volume_encrpytion_key")
  tags = merge(
    var.tags,
    lookup(var.workspace[count.index], "tags")
  )

  dynamic "workspace_properties" {
    for_each = lookup(var.workspace[count.index], "workspace_properties") == null ? [] : ["workspace_properties"]
    content {
      compute_type_name                         = lookup(workspace_properties.value, "compute_type_name")
      root_volume_size_gib                      = lookup(workspace_properties.value, "root_volume_size_gib")
      running_mode                              = lookup(workspace_properties.value, "running_mode")
      running_mode_auto_stop_timeout_in_minutes = lookup(workspace_properties.value, "running_mode_auto_stop_timeout_in_minutes")
      user_volume_size_gib                      = lookup(workspace_properties.value, "user_volume_size_gib")
    }
  }
}
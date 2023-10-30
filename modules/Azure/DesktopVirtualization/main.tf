resource "azurerm_resource_group" "this" {
  count    = length(var.resource_group) && var.resource_group_name == null
  location = lookup(var.resource_group[count.index], "location")
  name     = lookup(var.resource_group[count.index], "name")
  tags = merge(
    var.tags,
    lookup(var.resource_group[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "azurerm_role_definition" "this" {
  name  = "virtual-desktop"
  scope = azurerm_resource_group.this.id
  permissions {
    actions = [
      "Microsoft.Insights/eventtypes/values/read",
      "Microsoft.Compute/virtualMachines/deallocate/action",
      "Microsoft.Compute/virtualMachines/restart/action",
      "Microsoft.Compute/virtualMachines/powerOff/action",
      "Microsoft.Compute/virtualMachines/start/action",
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.DesktopVirtualization/hostpools/read",
      "Microsoft.DesktopVirtualization/hostpools/write",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/read",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/write",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/usersessions/delete",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/usersessions/read",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/usersessions/sendMessage/action",
      "Microsoft.DesktopVirtualization/hostpools/sessionhosts/usersessions/read"
    ]
    not_actions = []
  }
  assignable_scopes = [
    azurerm_resource_group.this.id,
  ]
}

resource "azurerm_role_assignment" "this" {
  count        = length(var.role_assignment) && var.role_assignment_name == null
  principal_id = data.azuread_service_principal.this.id
  scope = try(
    data.azurerm_resource_group.this.id,
    element(azurerm_resource_group.this.*.id, lookup(var.role_assignment[count.index], "resource_group_id"))
  )
  role_definition_id               = azurerm_role_definition.this.id
  skip_service_principal_aad_check = true
}

resource "azurerm_virtual_desktop_host_pool" "this" {
  count              = length(var.host_pool)
  load_balancer_type = lookup(var.host_pool[count.index], "load_balancer_type")
  location = try(
    data.azurerm_resource_group.this.location,
    element(azurerm_resource_group.this.location, lookup(var.host_pool[count.index], "resource_group_id"))
  )
  name = lookup(var.host_pool[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.name, lookup(var.host_pool[count.index], "resource_group_id"))
  )
  type                             = lookup(var.host_pool[count.index], "type")
  friendly_name                    = lookup(var.host_pool[count.index], "friendly_name")
  description                      = lookup(var.host_pool[count.index], "description")
  validate_environment             = lookup(var.host_pool[count.index], "validate_environment")
  start_vm_on_connect              = lookup(var.host_pool[count.index], "start_vm_on_connect")
  custom_rdp_properties            = lookup(var.host_pool[count.index], "custom_rdp_properties")
  personal_desktop_assignment_type = lookup(var.host_pool[count.index], "personal_desktop_assignment_type")
  maximum_sessions_allowed         = lookup(var.host_pool[count.index], "maximum_sessions_allowed")
  preferred_app_group_type         = lookup(var.host_pool[count.index], "preferred_app_group_type")
  tags = merge(
    var.tags,
    lookup(var.host_pool[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "scheduled_agent_updates" {
    for_each = lookup(var.host_pool[count.index], "scheduled_agent_updates") == null ? [] : ["scheduled_agent_updates"]
    content {
      enabled                   = lookup(scheduled_agent_updates.value, "enabled")
      timezone                  = lookup(scheduled_agent_updates.value, "timezone")
      use_session_host_timezone = lookup(scheduled_agent_updates.value, "use_session_host_timezone")

      dynamic "schedule" {
        for_each = lookup(scheduled_agent_updates.value, "schedule") == null ? [] : ["schedule"]
        content {
          day_of_week = lookup(schedule.value, "day_of_week")
          hour_of_day = lookup(schedule.value, "hour_of_day")
        }
      }
    }
  }
}

resource "azurerm_virtual_desktop_scaling_plan" "this" {
  count = length(var.scaling_plan)
  location = try(
    data.azurerm_resource_group.this.location,
    element(azurerm_resource_group.this.*.location, lookup(var.scaling_plan[count.index], "resource_group_id"))
  )
  name = lookup(var.scaling_plan[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.name, lookup(var.scaling_plan[count.index], "resource_group_id"))
  )
  time_zone     = lookup(var.scaling_plan[count.index], "time_zone")
  description   = lookup(var.scaling_plan[count.index], "description")
  exclusion_tag = lookup(var.scaling_plan[count.index], "exclusion_tag")
  friendly_name = lookup(var.scaling_plan[count.index], "friendly_name")
  tags = merge(
    var.tags,
    lookup(var.scaling_plan[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "host_pool" {
    for_each = lookup(var.scaling_plan[count.index], "host_pool") == null ? [] : ["host_pool"]
    content {
      hostpool_id = try(
        data.azurerm_virtual_desktop_host_pool.this.id,
        element(azurerm_virtual_desktop_host_pool.this.*.id, lookup(host_pool.value, "host_pool_id"))
      )
      scaling_plan_enabled = lookup(host_pool.value, "scaling_plan_enabled")
    }
  }

  dynamic "schedule" {
    for_each = lookup(var.host_pool[count.index], "schedule") == null ? [] : ["schedule"]
    content {
      days_of_week                         = lookup(schedule.value, "days_of_week")
      name                                 = lookup(schedule.value, "name")
      off_peak_load_balancing_algorithm    = lookup(schedule.value, "off_peak_load_balancing_algorithm")
      off_peak_start_time                  = lookup(schedule.value, "off_peak_start_time")
      peak_load_balancing_algorithm        = lookup(schedule.value, "peak_load_balancing_algorithm")
      peak_start_time                      = lookup(schedule.value, "peak_start_time")
      ramp_down_capacity_threshold_percent = lookup(schedule.value, "ramp_down_capacity_threshold_percent")
      ramp_down_force_logoff_users         = lookup(schedule.value, "ramp_down_force_logoff_users")
      ramp_down_load_balancing_algorithm   = lookup(schedule.value, "ramp_down_load_balancing_algorithm")
      ramp_down_minimum_hosts_percent      = lookup(schedule.value, "ramp_down_minimum_hosts_percent")
      ramp_down_notification_message       = lookup(schedule.value, "ramp_down_notification_message")
      ramp_down_start_time                 = lookup(schedule.value, "ramp_down_start_time")
      ramp_down_stop_hosts_when            = lookup(schedule.value, "ramp_down_stop_hosts_when")
      ramp_down_wait_time_minutes          = lookup(schedule.value, "ramp_down_wait_time_minutes")
      ramp_up_load_balancing_algorithm     = lookup(schedule.value, "ramp_up_load_balancing_algorithm")
      ramp_up_start_time                   = lookup(schedule.value, "ramp_up_start_time")
      ramp_up_capacity_threshold_percent   = lookup(schedule.value, "ramp_up_capacity_threshold_percent")
      ramp_up_minimum_hosts_percent        = lookup(schedule.value, "ramp_up_minimum_hosts_percent")
    }
  }
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "this" {
  count           = length(var.registration_info)
  expiration_date = timestamp()
  hostpool_id = try(
    data.azurerm_virtual_desktop_host_pool.this.id,
    element(azurerm_virtual_desktop_host_pool.this.*.id, lookup(var.registration_info[count.index], "host_pool_id"))
  )
}

resource "azurerm_virtual_desktop_application_group" "this" {
  count = length(var.application_group)
  host_pool_id = try(
    data.azurerm_virtual_desktop_host_pool.this.id,
    element(azurerm_virtual_desktop_host_pool.this.*.id, lookup(var.application_group[count.index], "host_group_id"))
  )
  location = try(
    data.azurerm_resource_group.this.location,
    element(azurerm_resource_group.this.location, lookup(var.application_group[count.index], "resource_group_id"))
  )
  name = lookup(var.application_group[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.name, lookup(var.application_group[count.index], "resource_group_id"))
  )
  type                         = lookup(var.application_group[count.index], "type")
  friendly_name                = lookup(var.application_group[count.index], "friendly_name")
  default_desktop_display_name = lookup(var.application_group[count.index], "default_desktop_display_name")
  description                  = lookup(var.application_group[count.index], "description")
  tags = merge(
    var.tags,
    lookup(var.application_group[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "azurerm_virtual_desktop_application" "this" {
  count = length(var.desktop_application)
  application_group_id = try(
    element(azurerm_virtual_desktop_application_group.this.*.id, lookup(var.desktop_application[count.index], "application_group_id"))
  )
  command_line_argument_policy = lookup(var.desktop_application[count.index], "command_line_argument_policy")
  name                         = lookup(var.desktop_application[count.index], "name")
  path                         = lookup(var.desktop_application[count.index], "path")
  friendly_name                = lookup(var.desktop_application[count.index], "friendly_name")
  description                  = lookup(var.desktop_application[count.index], "description")
  command_line_arguments       = lookup(var.desktop_application[count.index], "command_line_arguments")
  show_in_portal               = lookup(var.desktop_application[count.index], "show_in_portal")
  icon_path                    = lookup(var.desktop_application[count.index], "icon_path")
  icon_index                   = lookup(var.desktop_application[count.index], "icon_index")
}

resource "azurerm_virtual_desktop_workspace" "this" {
  count = length(var.desktop_workspace)
  location = try(
    data.azurerm_resource_group.this.location,
    element(azurerm_resource_group.this.*.location, lookup(var.desktop_workspace[count.index], "resource_group_id"))
  )
  name = lookup(var.desktop_workspace[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.desktop_workspace[count.index], "resource_group_id"))
  )
  friendly_name                 = lookup(var.desktop_workspace[count.index], "friendly_name")
  description                   = lookup(var.desktop_workspace[count.index], "description")
  public_network_access_enabled = lookup(var.desktop_workspace[count.index], "public_network_access_enabled")
  tags = merge(
    var.tags,
    lookup(var.desktop_workspace[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "this" {
  count = length(var.group_association)
  application_group_id = try(
    element(azurerm_virtual_desktop_application_group.this.*.name, lookup(var.group_association[count.index], "application_group_id"))
  )
  workspace_id = try(
    element(azurerm_virtual_desktop_workspace.this.*.id, lookup(var.group_association[count.index], "workspace_id"))
  )
}
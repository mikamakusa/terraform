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

resource "azurerm_user_assigned_identity" "this" {
  count               = length(var.user_assigned_identity)
  location            = lookup(var.user_assigned_identity[count.index], "location")
  name                = lookup(var.user_assigned_identity[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.user_assigned_identity[count.index], "resource_group_id"))
  )
  tags = merge(
    var.tags,
    lookup(var.user_assigned_identity[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "azurerm_key_vault" "this" {
  count                           = length(var.key_vault)
  location                        = lookup(var.key_vault[count.index], "location")
  name                            = lookup(var.key_vault[count.index], "name")
  resource_group_name             = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.key_vault[count.index], "resource_group_id"))
  )
  sku_name                        = lookup(var.key_vault[count.index], "sku_name")
  tenant_id                       = data.azurerm_client_config.this.tenant_id
  enable_rbac_authorization       = lookup(var.key_vault[count.index], "enable_rbac_authorization")
  enabled_for_deployment          = lookup(var.key_vault[count.index], "enabled_for_deployment")
  enabled_for_disk_encryption     = lookup(var.key_vault[count.index], "enabled_for_disk_encryption")
  enabled_for_template_deployment = lookup(var.key_vault[count.index], "enabled_for_template_deployment")
  purge_protection_enabled        = lookup(var.key_vault[count.index], "purge_protection_enabled")
  public_network_access_enabled   = lookup(var.key_vault[count.index], "public_network_access_enabled")
  soft_delete_retention_days      = lookup(var.key_vault[count.index], "soft_delete_retention_days")
  tags = merge(
    var.tags,
    lookup(var.key_vault[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "contact" {
    for_each = lookup(var.key_vault[count.index], "contact") == null ? [] : ["contact"]
    content {
      email = lookup(contact.value, "email")
      name  = lookup(contact.value, "name")
      phone = lookup(contact.value, "phone")
    }
  }

  dynamic "network_acls" {
    for_each = lookup(var.key_vault[count.index], "network_acls") == null ? [] : ["network_acls"]
    content {
      bypass                     = lookup(network_acls.value, "bypass")
      default_action             = lookup(network_acls.value, "default_action")
      ip_rules                   = lookup(network_acls.value, "ip_rules")
      virtual_network_subnet_ids = lookup(network_acls.value, "virtual_network_subnet_ids")
    }
  }

  dynamic "access_policy" {
    for_each = lookup(var.key_vault[count.index], "access_policy") == null ? [] : ["access_policy"]
    content {
      tenant_id               = data.azurerm_client_config.this.tenant_id
      application_id          = lookup(access_policy.value, "application_id")
      object_id               = data.azurerm_client_config.this.object_id
      certificate_permissions = lookup(access_policy.value, "certificate_permissions")
      key_permissions         = lookup(access_policy.value, "key_permissions")
      secret_permissions      = lookup(access_policy.value, "secret_permissions")
      storage_permissions     = lookup(access_policy.value, "storage_permissions")
    }
  }
}

resource "azurerm_key_vault_access_policy" "this" {
  count                   = length(var.key_vault_access_policy)
  key_vault_id            = try(
    data.azurerm_key_vault.this.id,
    element(azurerm_key_vault.this.*.id, lookup(var.key_vault_access_policy[count.index], "key_vault_id"))
  )
  object_id               = data.azurerm_client_config.this.object_id
  tenant_id               = data.azurerm_client_config.this.tenant_id
  application_id          = lookup(var.key_vault_access_policy[count.index], "application_id")
  certificate_permissions = lookup(var.key_vault_access_policy[count.index], "certificate_permissions")
  key_permissions         = lookup(var.key_vault_access_policy[count.index], "key_permissions")
  secret_permissions      = lookup(var.key_vault_access_policy[count.index], "secret_permissions")
  storage_permissions     = lookup(var.key_vault_access_policy[count.index], "storage_permissions")
}

resource "azurerm_key_vault_key" "this" {
  count           = length(var.key)
  key_opts        = lookup(var.key[count.index], "key_opts")
  key_type        = lookup(var.key[count.index], "key_type")
  key_vault_id    = try(
    data.azurerm_key_vault.this.id,
    element(azurerm_key_vault.this.*.id, lookup(var.key[count.index], "key_vault_id"))
  )
  name            = lookup(var.key[count.index], "name")
  key_size        = lookup(var.key[count.index], "key_size")
  curve           = lookup(var.key[count.index], "curve")
  not_before_date = lookup(var.key[count.index], "not_before_date")
  expiration_date = lookup(var.key[count.index], "expiration_date")
  tags = merge(
    var.tags,
    lookup(var.key[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "rotation_policy" {
    for_each = lookup(var.key[count.index], "rotation_policy") == null ? [] : ["rotation_policy"]
    content {
      expire_after         = lookup(rotation_policy.value, "expire_after")
      notify_before_expiry = lookup(rotation_policy.value, "notify_before_expiry")
      automatic {
        time_after_creation = lookup(rotation_policy.value, "time_after_creation")
        time_before_expiry  = lookup(rotation_policy.value, "time_before_expiry")
      }
    }
  }
}

resource "azurerm_key_vault_secret" "this" {
  count        = length(var.secrets)
  key_vault_id = try(
    data.azurerm_key_vault.this.id,
    element(azurerm_key_vault.this.*.id, lookup(var.secrets[count.index], "key_vault_id"))
  )
  name         = lookup(var.secrets[count.index], "name")
  value        = lookup(var.secrets[count.index], "value")
  content_type = lookup(var.secrets[count.index], "content_type")
  tags = merge(
    var.tags,
    lookup(var.secrets[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  not_before_date = lookup(var.secrets[count.index], "not_before_date")
  expiration_date = lookup(var.secrets[count.index], "expiration_date")
}

resource "azurerm_app_configuration" "this" {
  count                      = length(var.app_configuration)
  location                   = lookup(var.app_configuration[count.index], "location")
  name                       = lookup(var.app_configuration[count.index], "name")
  resource_group_name        = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.app_configuration[count.index], "resource_group_id"))
  )
  local_auth_enabled         = lookup(var.app_configuration[count.index], "local_auth_enabled")
  public_network_access      = lookup(var.app_configuration[count.index], "public_network_access")
  purge_protection_enabled   = lookup(var.app_configuration[count.index], "purge_protection_enabled")
  sku                        = lookup(var.app_configuration[count.index], "sku")
  soft_delete_retention_days = lookup(var.app_configuration[count.index], "soft_delete_retention_days")
  tags = merge(
    var.tags,
    lookup(var.app_configuration[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "identity" {
    for_each = lookup(var.app_configuration[count.index], "identity")
    content {
      type = lookup(identity.value, "type")
      identity_ids = [
        try(
          data.azurerm_user_assigned_identity.this.id,
          element(azurerm_user_assigned_identity.this.*.id, lookup(var.app_configuration[count.index], "identity_ids"))
        )
      ]
    }
  }

  dynamic "encryption" {
    for_each = lookup(var.app_configuration[count.index], "encryption")
    content {
      key_vault_key_identifier = try(
        data.azurerm_key_vault.this.id,
        element(azurerm_key_vault_key.this.*.id, lookup(encryption.value, "key_vault_key_id"))
      )
      identity_client_id       = try(
        data.azurerm_user_assigned_identity.this.id,
        element(azurerm_user_assigned_identity.this.*.id, lookup(encryption.value, "identity_client_id"))
      )
    }
  }

  dynamic "replica" {
    for_each = lookup(var.app_configuration[count.index], "replica")
    content {
      location = lookup(replica.value, "location")
      name     = lookup(replica.value, "name")
    }
  }
}

resource "azurerm_role_assignment" "this" {
  count                            = length(var.role_assignment)
  principal_id                     = try(data.azurerm_client_config.this.object_id)
  scope                            = try(data.azurerm_management_group.this.id)
  name                             = lookup(var.role_assignment[count.index], "name")
  role_definition_id               = try(data.azurerm_role_definition.this.id)
  role_definition_name             = try(data.azurerm_role_definition.this.name)
  condition                        = lookup(var.role_assignment[count.index], "condition")
  condition_version                = lookup(var.role_assignment[count.index], "condition_version")
  description                      = lookup(var.role_assignment[count.index], "description")
  skip_service_principal_aad_check = lookup(var.role_assignment[count.index], "skip_service_principal_aad_check")
}

resource "azurerm_app_configuration_feature" "this" {
  count                   = length(var.feature)
  configuration_store_id  = try(element(azurerm_app_configuration.this.*.id, lookup(var.feature[count.index], "configuration_store_id")))
  name                    = lookup(var.feature[count.index], "name")
  description             = lookup(var.feature[count.index], "description")
  key                     = lookup(var.feature[count.index], "key")
  label                   = lookup(var.feature[count.index], "label")
  locked                  = lookup(var.feature[count.index], "locked")
  percentage_filter_value = lookup(var.feature[count.index], "percentage_filter_value")
  tags = merge(
    var.tags,
    lookup(var.feature[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "targeting_filter" {
    for_each = lookup(var.feature[count.index], "targeting_filter") == null ? [] : ["targeting_filter"]
    content {
      default_rollout_percentage = lookup(targeting_filter.value, "default_rollout_percentage")
      users                      = lookup(targeting_filter.value, "users")

      dynamic "groups" {
        for_each = lookup(targeting_filter.value, "groups") == null ? [] : ["groups"]
        content {
          name               = lookup(groups.value, "name")
          rollout_percentage = lookup(groups.value, "rollout_percentage")
        }
      }
    }
  }

  dynamic "timewindow_filter" {
    for_each = lookup(var.feature[count.index], "timewindow_filter") == null ? [] : ["timewindow_filter"]
    content {
      start = lookup(timewindow_filter.value, "start")
      end   = lookup(timewindow_filter.value, "end")
    }
  }
}

resource "azurerm_app_configuration_key" "this" {
  count                  = length(var.configuration_key)
  configuration_store_id = try(element(azurerm_app_configuration.this.*.id, lookup(var.configuration_key[count.index], "configuration_store_id")))
  key                    = lookup(var.configuration_key[count.index], "key")
  content_type           = lookup(var.configuration_key[count.index], "content_type")
  label                  = lookup(var.configuration_key[count.index], "label")
  value                  = lookup(var.configuration_key[count.index], "value")
  locked                 = lookup(var.configuration_key[count.index], "locked")
  type                   = lookup(var.configuration_key[count.index], "type")
  vault_key_reference    = try(
    element(azurerm_key_vault_secret.this.*.versionless_id, lookup(var.configuration_key[count.index], "vault_key_id")),
    data.azurerm_key_vault_secret.this.versionless_id,
    data.azurerm_key_vault_key.this.versionless_id,
    element(azurerm_key_vault_key.this.*.versionless_id, lookup(var.configuration_key[count.index], "vault_key_id"))
  )
  tags                   = lookup(var.configuration_key[count.index], "tags")
}
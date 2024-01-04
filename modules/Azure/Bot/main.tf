resource "azurerm_cognitive_account" "this" {
  count               = length(var.cognitive_account)
  kind                = lookup(var.cognitive_account[count.index], "kind")
  location            = try(data.azurerm_resource_group.this.location)
  name                = lookup(var.cognitive_account[count.index], "name")
  resource_group_name = try(data.azurerm_resource_group.this.name)
  sku_name            = lookup(var.cognitive_account[count.index], "sku_name")
}

resource "azurerm_bot_channel_alexa" "this" {
  count = length(var.alexa) == "0" ? "0" : (length(var.registration))
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.alexa[count.index], "registration_id"))
  )
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.alexa[count.index], "registration_id"))
  )
  resource_group_name = data.azurerm_resource_group.this.name
  skill_id            = lookup(var.alexa[count.index], "skill_id")
}

resource "azurerm_bot_channel_direct_line_speech" "this" {
  count = length(var.direct_line_speech) == "0" ? "0" : (length(var.registration))
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.direct_line_speech[count.index], "registration_id"))
  )
  cognitive_service_access_key = try(
    data.azurerm_cognitive_account.this.primary_access_key,
    element(azurerm_cognitive_account.this.*.primary_access_key, lookup(var.direct_line_speech[count.index], "cognitive_account_id"))

  )
  cognitive_service_location = try(
    data.azurerm_cognitive_account.this.location,
    element(azurerm_cognitive_account.this.*.location, lookup(var.direct_line_speech[count.index], "cognitive_account_id"))
  )
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.direct_line_speech[count.index], "registration_id"))
  )
  resource_group_name = data.azurerm_resource_group.this.name
  cognitive_account_id = try(
    data.azurerm_cognitive_account.this.id,
    element(azurerm_cognitive_account.this.*.id, lookup(var.direct_line_speech[count.index], "cognitive_account_id"))
  )
}

resource "azurerm_bot_channel_directline" "this" {
  count = length(var.directline) == "0" ? "0" : length(var.registration)
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.directline[count.index], "registration_id"))
  )
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.directline[count.index], "registration_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
}

resource "azurerm_bot_channel_email" "this" {
  count = length(var.email) == "0" ? "0" : length(var.registration)
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.email[count.index], "registration_id"))
  )
  email_address  = lookup(var.email[count.index], "email_address")
  email_password = sensitive(lookup(var.email[count.index], "email_password"))
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.email[count.index], "location"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
}

resource "azurerm_bot_channel_facebook" "this" {
  count = length(var.facebook) == "0" ? "0" : length(var.registration)
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.facebook[count.index], "registration_id"))
  )
  facebook_application_id     = lookup(var.facebook[count.index], "facebook_application_id")
  facebook_application_secret = sensitive(lookup(var.facebook[count.index], "facebook_application_secret"))
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.facebook[count.index], "registration_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
}

resource "azurerm_bot_channel_line" "this" {
  count = length(var.channel_line) == "0" ? "0" : length(var.registration)
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.channel_line[count.index], "registration_id"))
  )
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.channel_line[count.index], "registration_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )

  dynamic "line_channel" {
    for_each = lookup(var.channel_line[count.index], "line_channel")
    content {
      access_token = lookup(line_channel.value, "access_token")
      secret       = sensitive(lookup(line_channel.value, "secret"))
    }
  }
}

resource "azurerm_bot_channel_ms_teams" "this" {
  count = length(var.ms_teams) == "0" ? "0" : length(var.registration)
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.ms_teams[count.index], "registration_id"))
  )
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.ms_teams[count.index], "registration_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  calling_web_hook       = lookup(var.ms_teams[count.index], "calling_web_hook")
  deployment_environment = lookup(var.ms_teams[count.index], "deployment_environment")
  enable_calling         = lookup(var.ms_teams[count.index], "enable_calling")
}

resource "azurerm_bot_channel_slack" "this" {
  count = length(var.slack) == "0" ? "0" : length(var.registration)
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.slack[count.index], "registration_id"))
  )
  client_id     = lookup(var.slack[count.index], "client_id")
  client_secret = sensitive(lookup(var.slack[count.index], "client_secret"))
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.slack[count.index], "registration_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  verification_token = sensitive(lookup(var.slack[count.index], "verification_token"))
  landing_page_url   = lookup(var.slack[count.index], "landing_page_url")
  signing_secret     = sensitive(lookup(var.slack[count.index], "signing_secret"))
}

resource "azurerm_bot_channel_sms" "this" {
  count = length(var.sms) == "0" ? "0" : length(var.registration)
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.sms[count.index], "registration_id"))
  )
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.sms[count.index], "registration_id"))
  )
  phone_number = lookup(var.sms[count.index], "phone_number")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  sms_channel_account_security_id = sensitive(lookup(var.sms[count.index], "sms_channel_account_security_id"))
  sms_channel_auth_token          = sensitive(lookup(var.sms[count.index], "sms_channel_auth_token"))
}

resource "azurerm_bot_channel_web_chat" "this" {
  count = length(var.web_chat) == "0" ? "0" : length(var.registration)
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.web_chat[count.index], "registration_id"))
  )
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.web_chat[count.index], "registration_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )

  dynamic "site" {
    for_each = lookup(var.web_chat[count.index], "site") == null ? [] : ["site"]
    content {
      name                        = lookup(site.value, "name")
      user_upload_enabled         = lookup(site.value, "user_upload_enabled")
      endpoint_parameters_enabled = lookup(site.value, "endpoint_parameters_enabled")
      storage_enabled             = lookup(site.value, "storage_enabled")
    }
  }
}

resource "azurerm_bot_channels_registration" "this" {
  count = length(var.registration)
  location = try(
    data.azurerm_resource_group.this.location,
    lookup(var.registration[count.index], "location")
  )
  microsoft_app_id    = data.azurerm_client_config.current.client_id
  name                = lookup(var.registration[count.index], "name")
  resource_group_name = try(data.azurerm_resource_group.this.name)
  sku                 = lookup(var.registration[count.index], "sku")
  cmk_key_vault_url   = lookup(var.registration[count.index], "cmk_key_vault_url")
}

resource "azurerm_bot_connection" "this" {
  count = length(var.bot_connection) == "0" ? "0" : length(var.registration)
  bot_name = try(
    element(azurerm_bot_channels_registration.this.*.name, lookup(var.bot_connection[count.index], "registration_id"))
  )
  client_id     = sensitive(lookup(var.bot_connection[count.index], "client_id"))
  client_secret = sensitive(lookup(var.bot_connection[count.index], "client_secret"))
  location = try(
    element(azurerm_bot_channels_registration.this.*.location, lookup(var.bot_connection[count.index], "location"))
  )
  name = lookup(var.bot_connection[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  service_provider_name = lookup(var.bot_connection[count.index], "service_provider_name")
  scopes                = lookup(var.bot_connection[count.index], "scopes")
  parameters            = lookup(var.bot_connection[count.index], "parameters")
}

resource "azurerm_bot_service_azure_bot" "this" {
  count = length(var.azure_bot)
  location = try(
    data.azurerm_resource_group.this.location,
    lookup(var.azure_bot[count.index], "location")
  )
  microsoft_app_id                      = data.azurerm_client_config.current.client_id
  name                                  = lookup(var.azure_bot[count.index], "name")
  resource_group_name                   = data.azurerm_resource_group.this.name
  sku                                   = lookup(var.azure_bot[count.index], "sku")
  developer_app_insights_api_key        = sensitive(lookup(var.azure_bot[count.index], "developer_app_insights_api_key"))
  developer_app_insights_application_id = lookup(var.azure_bot[count.index], "developer_app_insights_application_id")
  developer_app_insights_key            = sensitive(lookup(var.azure_bot[count.index], "developer_app_insights_key"))
  display_name                          = lookup(var.azure_bot[count.index], "display_name")
  endpoint                              = lookup(var.azure_bot[count.index], "endpoint")
  icon_url                              = lookup(var.azure_bot[count.index], "icon_url")
  microsoft_app_msi_id                  = lookup(var.azure_bot[count.index], "microsoft_app_msi_id")
  microsoft_app_tenant_id               = lookup(var.azure_bot[count.index], "microsoft_app_tenant_id")
  microsoft_app_type                    = lookup(var.azure_bot[count.index], "microsoft_app_type")
  local_authentication_enabled          = lookup(var.azure_bot[count.index], "local_authentication_enabled")
  luis_app_ids                          = lookup(var.azure_bot[count.index], "luis_app_ids")
  luis_key                              = sensitive(lookup(var.azure_bot[count.index], "luis_key"))
  streaming_endpoint_enabled            = lookup(var.azure_bot[count.index], "streaming_endpoint_enabled")
  tags = merge(
    var.tags,
    lookup(var.azure_bot[count.index], "tags")
  )
}

resource "azurerm_bot_web_app" "this" {
  count = length(var.web_app)
  location = try(
    data.azurerm_resource_group.this.location,
    lookup(var.web_app[count.index], "location")
  )
  microsoft_app_id                      = data.azurerm_client_config.current.client_id
  name                                  = lookup(var.web_app[count.index], "name")
  resource_group_name                   = data.azurerm_resource_group.this.name
  sku                                   = lookup(var.web_app[count.index], "sku")
  display_name                          = lookup(var.web_app[count.index], "display_name")
  endpoint                              = lookup(var.web_app[count.index], "endpoint")
  developer_app_insights_api_key        = sensitive(lookup(var.web_app[count.index], "developer_app_insights_api_key"))
  developer_app_insights_application_id = lookup(var.web_app[count.index], "developer_app_insights_application_id")
  developer_app_insights_key            = lookup(var.web_app[count.index], "developer_app_insights_key")
  luis_app_ids                          = lookup(var.web_app[count.index], "luis_app_ids")
  luis_key                              = sensitive(lookup(var.web_app[count.index], "luis_key"))
  tags = merge(
    var.tags,
    lookup(var.web_app[count.index], "tags")
  )
}
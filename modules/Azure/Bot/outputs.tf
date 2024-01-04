output "channels" {
  value = try(
    azurerm_bot_channel_direct_line_speech.this,
    azurerm_bot_channel_alexa.this,
    azurerm_bot_channel_directline.this,
    azurerm_bot_channel_email.this,
    azurerm_bot_channel_facebook.this,
    azurerm_bot_channel_line.this,
    azurerm_bot_channel_ms_teams.this,
    azurerm_bot_channel_slack.this,
    azurerm_bot_channel_sms.this,
    azurerm_bot_channel_web_chat.this
  )
}

output "registration" {
  value = try(azurerm_bot_channels_registration.this)
}

output "connection" {
  value = try(azurerm_bot_connection.this)
}

output "azure_bot" {
  value = try(azurerm_bot_service_azure_bot)
}

output "web_app" {
  value = try(azurerm_bot_web_app.this)
}
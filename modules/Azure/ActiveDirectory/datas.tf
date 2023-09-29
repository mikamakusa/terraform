data "azuread_application" "this" {
  display_name = var.application
}
provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.78.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.45.0"
    }
  }
  required_version = "1.6.2"
}
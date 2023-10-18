terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.76.0"
    }
    azapi = {
      source = "Azure/azapi"
      version = "1.9.0"
    }
  }
  required_version = "1.5.7"
}

provider "azurerm" {
  features {}
}
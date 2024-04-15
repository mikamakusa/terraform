terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.98.0"
    }
  }
  required_version = "1.8.0"
}

provider "azurerm" {}
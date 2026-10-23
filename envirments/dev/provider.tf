terraform {
   backend "azurerm" {
    resource_group_name ="punit-sa"
    storage_account_name = "punitsa"                            
    container_name       = "tfstate"                               
    key                  = "dev.terraform.tfstate"                
 }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.10.0"
    }
  }
}


provider "azurerm" {
features {}
}
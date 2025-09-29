terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!@#$%&"
}


resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sql-tchungry-${random_string.suffix.result}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = random_password.password.result
}


resource "azurerm_mssql_database" "sqldb" {
  name      = "Hungry"
  server_id = azurerm_mssql_server.sqlserver.id 
  sku_name  = "S0"                             
}

 
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name      = "AllowAllWindowsAzureIps"
  server_id = azurerm_mssql_server.sqlserver.id  
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
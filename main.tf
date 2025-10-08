terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
 
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstatetchungryale"
    container_name       = "tfstate"
    key                  = "infra-data.tfstate"  
  }
}

provider "azurerm" {
  features {}
}

 
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

 

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sql-tchungry-hnaia0"
  resource_group_name          = data.azurerm_resource_group.rg.name 
  location                     = data.azurerm_resource_group.rg.location 
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = "R1Cz$lgv!mQNi6JE"  
}

resource "azurerm_mssql_database" "sqldb" {
  name      = "Hungry"
  server_id = azurerm_mssql_server.sqlserver.id
  sku_name  = "S0"
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAllWindowsAzureIps"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_storage_account" "storage" {
 
  name                     = "strgtchungryprod"
  resource_group_name      = data.azurerm_resource_group.rg.name # Usa o 'data' source
  location                 = data.azurerm_resource_group.rg.location # Usa o 'data' source
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "images" {
  name                  = "imagens"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}
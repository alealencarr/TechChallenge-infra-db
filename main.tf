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

# --- Data Sources ---

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# --- 1. SQL Server ---

resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = data.azurerm_resource_group.rg.name 
  location                     = data.azurerm_resource_group.rg.location 
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
  
  # Segurança adicional
  minimum_tls_version          = "1.2"
  public_network_access_enabled = true
}

# --- 2. SQL Database ---

resource "azurerm_mssql_database" "sqldb" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.sqlserver.id
  sku_name  = "S0"
  
  # Configurações adicionais
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 250
  zone_redundant = false
}

# --- 3. SQL Firewall Rules ---

# Permite serviços do Azure acessarem o SQL Server
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAllWindowsAzureIps"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# --- 4. Storage Account ---

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  # Segurança
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = true
  
  # Proteção contra exclusão acidental
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
}

# --- 5. Storage Container para Imagens ---

resource "azurerm_storage_container" "images" {
  name                  = "imagens"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}
 
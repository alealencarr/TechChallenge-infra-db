variable "resource_group_name" {
  type        = string
  description = "Nome do resource group onde os recursos serão criados"
  default     = "rg-tchungry-prod"
}

variable "location" {
  type        = string
  description = "Região do Azure"
  default     = "Brazil South"
}

variable "sql_server_name" {
  type        = string
  description = "Nome do SQL Server"
  default     = "sql-tchungry-hnaia0"
}

variable "sql_database_name" {
  type        = string
  description = "Nome do banco de dados"
  default     = "Hungry"
}

variable "sql_admin_login" {
  type        = string
  description = "Username do admin do SQL Server"
  default     = "admintchungry"
}

variable "sql_admin_password" {
  type        = string
  description = "Senha do admin do SQL Server"
  sensitive   = true
  default     = "R1Cz$lgv!mQNi6JE"
}

variable "storage_account_name" {
  type        = string
  description = "Nome do Storage Account"
  default     = "strgtchungryprod"
}

variable "resource_group_name" {
  type        = string
  description = "O nome do grupo de recursos onde tudo será criado."
  default     = "rg-tchungry-prod"
}

variable "location" {
  type        = string
  description = "A região do Azure onde os recursos serão criados."
  default     = "Brazil South"
}

variable "sql_admin_login" {
  type        = string
  description = "O nome de usuário para o administrador do SQL Server."
  default     = "admintchungry"
}
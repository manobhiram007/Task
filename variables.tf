variable "resource_group_name" {
  description = "The name of the Azure resource group."
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
}

variable "vnet" {
  description = "The name of the Virtual network."
}

variable "vm_name" {
  description = "The name of the Virtual Machine."
}

variable "subnet" {
  description = "name of subnet."
}

variable "vm_size" {
  description = "The size of the Virtual Machine."
}

variable "nicname" {
  description = "The name of nic."
}

variable "key_vault_name" {
  description = "The name of the Key Vault."
}

variable "storage_account_name" {
  description = "The name of the Storage Account."
}

variable "storage_account_tier" {
  description = "The tier of the Storage Account."
}

variable "storage_account_replication_type" {
  description = "The replication type of the Storage Account."
}

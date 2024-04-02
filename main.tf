terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.90.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

# Resource Group
resource "azurerm_resource_group" "R1" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet
  resource_group_name = azurerm_resource_group.R1.name
  location            = azurerm_resource_group.R1.location
  address_space       = ["10.20.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.R1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.20.1.0/24"] # Adjust this according to your network requirements
}

resource "azurerm_network_interface" "nic1" {
  name                = var.nicname
  resource_group_name = azurerm_resource_group.R1.name
  location            = azurerm_resource_group.R1.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "VM" {
  name                            = var.vm_name
  resource_group_name             = azurerm_resource_group.R1.name
  location                        = azurerm_resource_group.R1.location
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "P@ssw0rd1234!"
  network_interface_ids           = [azurerm_network_interface.nic1.id]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

# Key Vault
resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  resource_group_name         = azurerm_resource_group.R1.name
  location                    = var.location
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
}

# Storage Account
resource "azurerm_storage_account" "SA" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.R1.name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}


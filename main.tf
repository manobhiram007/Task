# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
}

# Declare the Azure provider configuration
provider "azurerm" {
  features {}
  subscription_id = "905e5ecb-b57f-4908-a061-9861012bdc85"
  client_id       = "5a7c9b2e-09dd-4b78-b863-de343c1b36e0"
  client_secret   = "Uqb8Q~w36mxopboUmh4T.0_iw9relgxmB3aOzc~J"
  tenant_id       = "9cf21cba-3ac1-4621-a2de-d66ad53e67a0"
}

# Declare the Azure client configuration data source
data "azurerm_client_config" "current" {}

# Declare the Azure resources
resource "azurerm_resource_group" "pr" {
  name     = "${var.gpname}"
  location = "${var.gplocation}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.example}"
  location            = azurerm_resource_group.pr.location
  resource_group_name = azurerm_resource_group.pr.name
  address_space       = ["${var.cidr_address}"]
}

resource "azurerm_subnet" "sub1" {
  name                 = "${var.example1}"
  resource_group_name  = azurerm_resource_group.pr.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.cidr_address1}"]
}

resource "azurerm_storage_account" "stg" {
  name                     = "${var.storage_name}"
  resource_group_name      = azurerm_resource_group.pr.name
  location                 = azurerm_resource_group.pr.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_key_vault" "key" {
  name                = "${var.key_vault_name}"
  location            = azurerm_resource_group.pr.location
  resource_group_name = azurerm_resource_group.pr.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "Delete"
    ]

    storage_permissions = [
      "Get",
      "List",
      "Set",
      "SetSAS",
      "GetSAS",
      "DeleteSAS",
      "Update",
      "RegenerateKey"
    ]
  }
}

resource "azurerm_network_interface" "main" {
  name                = "${var.network_interface_name}"
  location            = azurerm_resource_group.pr.location
  resource_group_name = azurerm_resource_group.pr.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.sub1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "${var.virtual_machine_name}"
  location              = azurerm_resource_group.pr.location
  resource_group_name   = azurerm_resource_group.pr.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

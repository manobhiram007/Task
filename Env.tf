# main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.9.0"
    }
  }
}

module "module_dev" {
  source                        = "./modules/azure"
  gpname                        = "abhidev"
  gplocation                    = "eastus"
  example                       = "myvnet"
  cidr_address                  = "10.0.0.0/16"
  example1                      = "mysubnet"
  cidr_address1                 = "10.0.2.0/24"
  storage_name                  = "abhidevstg"
  key_vault_name                = "abhidevkeyvault"
  network_interface_name        = "devnetworkinterface"
  virtual_machine_name          = "devvirtualmachine"
}


module "module_qa" {
  source                        = "./modules/azure"
  gpname                        = "abhiqa"
  gplocation                    = "eastus"
  example                       = "qavnet"
  cidr_address                  = "10.30.0.0/16"
  example1                      = "qasubnet"
  cidr_address1                 = "10.30.2.0/24"
  storage_name                  = "abhiqastorageaccount"
  key_vault_name                = "abhiqakeyvault"
  network_interface_name        = "qanetworkinterface"
  virtual_machine_name          = "qavirtualmachine"
}

module "module_staging" {
  source                        = "./modules/azure"
  gpname                        = "stagingrg"
  gplocation                    = "eastus"
  example                       = "stagingvnet"
  cidr_address                  = "10.40.0.0/16"
  example1                      = "stagingsubnet"
  cidr_address1                 = "10.40.2.0/24"
  storage_name                  = "stagingstorageaccount"
  key_vault_name                = "stagingkeyvault"
  network_interface_name        = "stagingnetworkinterface"
  virtual_machine_name          = "stagingvirtualmachine"
}

module "module_prod" {
  source                        = "./modules/azure"
  gpname                        = "abhiprod"
  gplocation                    = "eastus"
  example                       = "prodvnet"
  cidr_address                  = "10.50.0.0/16"
  example1                      = "prodsubnet"
  cidr_address1                 = "10.50.2.0/24"
  storage_name                  = "abhiprodstorageaccount"
  key_vault_name                = "abhiprodkeyvault"
  network_interface_name        = "abhiprodntinf"
  virtual_machine_name          = "abhiprodevm"
}





# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {
    resource_group {
    prevent_deletion_if_contains_resources = false
  }
  }
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

#second resource group
/*
resource "azurerm_resource_group" "rg2" {
  name     = var.resource_group_name2
  location = var.location2
}
*/

resource "azurerm_virtual_network" "example" {
  name                = var.vnet1
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = var.subnet1
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

/*
resource "azurerm_virtual_network" "example2" {
  name                = var.vnet2
  resource_group_name = azurerm_resource_group.rg2.name
  location            = azurerm_resource_group.rg2.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "internal2" {
  name                 = var.subnet2
  resource_group_name  = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.0.2.0/24"]
}
*/

resource "azurerm_windows_virtual_machine_scale_set" "example" {
  name                = var.vmss1
  computer_name_prefix = "vmss1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.vmsku
  instances           = 2
  admin_password      = var.vmsspassword
  admin_username      = var.vmssusername
  zones = [1,2,3]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-core"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = var.nat1
    primary = true

    ip_configuration {
      name      = var.ipconfig
      primary   = true
      subnet_id = azurerm_subnet.internal.id
    }
  }
}

#Second VMSS
/*
resource "azurerm_windows_virtual_machine_scale_set" "example2" {
  name                = var.vmss2
  computer_name_prefix = "vmss2"
  resource_group_name = azurerm_resource_group.rg2.name
  location            = azurerm_resource_group.rg2.location
  sku                 = var.vmsku
  instances           = 2
  admin_password      = var.vmsspassword
  admin_username      = var.vmssusername
  #zones = [1,2,3]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-core"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = var.nat2
    primary = true

    ip_configuration {
      name      = var.ipconfig2
      primary   = true
      subnet_id = azurerm_subnet.internal2.id
    }
  }
}
*/
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "shows" {
  name     = "rg-shows"
  location = "UK South"
}

resource "azurerm_storage_account" "shows" {
  name                     = "showsstorageacct"
  resource_group_name      = azurerm_resource_group.shows.name
  location                 = azurerm_resource_group.shows.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "shows" {
  name                  = "show-storage-container"
  storage_account_name  = azurerm_storage_account.shows.name
  container_access_type = "private"
}

resource "azurerm_service_plan" "shows" {
  name                = "shows_sp"
  resource_group_name = azurerm_resource_group.shows.name
  location            = azurerm_resource_group.shows.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "shows" {
  name                       = "app-shows"
  location                   = azurerm_resource_group.shows.location
  resource_group_name        = azurerm_resource_group.shows.name
  service_plan_id        = azurerm_service_plan.shows.id
  storage_account_name       = azurerm_storage_account.shows.name
  storage_account_access_key = azurerm_storage_account.shows.primary_access_key

  site_config {
    application_stack {
      java_version = "17"
    }
  }
}

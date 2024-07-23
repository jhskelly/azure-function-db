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

resource "azurerm_app_service_plan" "shows" {
  name                = "asp-shows"
  location            = azurerm_resource_group.shows.location
  resource_group_name = azurerm_resource_group.shows.name
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "shows" {
  name                       = "app-shows"
  location                   = azurerm_resource_group.shows.location
  resource_group_name        = azurerm_resource_group.shows.name
  app_service_plan_id        = azurerm_app_service_plan.shows.id
  storage_account_name       = azurerm_storage_account.shows.name
  storage_account_access_key = azurerm_storage_account.shows.primary_access_key
  os_type                    = "linux"
  runtime_stack              = "java"
  version                    = "~3"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "java"
    JAVA_VERSION             = "11"
    WEBSITE_RUN_FROM_PACKAGE = "1"
  }

  site_config {
    always_on                = true
    java_version             = "11"
  }
}

data "terraform_remote_state" "hub" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstatecapstone01"
    container_name       = "tfstate"
    key                  = "hub.tfstate"
  }
}

resource "azurerm_monitor_diagnostic_setting" "subscription_activity" {
  name = "diag-subscription-activity"

  target_resource_id = "/subscriptions/${var.subscription_id}"

  log_analytics_workspace_id = data.terraform_remote_state.hub.outputs.log_analytics_workspace_id

  enabled_log {
    category = "Administrative"
  }

  enabled_log {
    category = "Security"
  }

  enabled_log {
    category = "ServiceHealth"
  }

  enabled_log {
    category = "Alert"
  }

  enabled_log {
    category = "Recommendation"
  }

  enabled_log {
    category = "Policy"
  }

  enabled_log {
    category = "ResourceHealth"
  }
}
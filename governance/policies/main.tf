resource "azurerm_policy_definition" "allowed_locations" {
  name         = "policy-allowed-locations"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Allowed Azure locations"

  policy_rule = jsonencode({
    "if" = {
      field = "location"
      notIn = var.allowed_locations
    }

    "then" = {
      effect = "deny"
    }
  })

  parameters = jsonencode({})
}

resource "azurerm_policy_definition" "require_environment_tag" {
  name         = "policy-require-environment-tag"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require Environment tag"

  policy_rule = jsonencode({
    "if" = {
      allOf = [
        {
          field  = "tags['Environment']"
          exists = "false"
        },
        {
          field = "type"
          notIn = [
            "Microsoft.Network/dnsResolvers/inboundEndpoints",
            "Microsoft.Network/privateDnsZones/virtualNetworkLinks"
          ]
        }
      ]
    }

    "then" = {
      effect = "deny"
    }
  })

  parameters = jsonencode({})
}

resource "azurerm_subscription_policy_assignment" "allowed_locations" {
  name                 = "assign-allowed-locations"
  display_name         = "Allowed Azure locations"
  policy_definition_id = azurerm_policy_definition.allowed_locations.id
  subscription_id      = "/subscriptions/${var.subscription_id}"

  parameters = jsonencode({})
}

resource "azurerm_subscription_policy_assignment" "require_environment_tag" {
  name                 = "assign-environment-tag"
  display_name         = "Require Environment tag"
  policy_definition_id = azurerm_policy_definition.require_environment_tag.id
  subscription_id      = "/subscriptions/${var.subscription_id}"

  parameters = jsonencode({})
}
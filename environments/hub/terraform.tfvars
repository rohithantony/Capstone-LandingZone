resource_group_name = "rg-hub"
location            = "eastus"

virtual_network_name          = "vnet-hub"
virtual_network_address_space = ["10.0.0.0/16"]

tags = {
  Environment = "hub"
  Project     = "capstone-landing-zone"
  ManagedBy   = "Terraform"
}

enable_firewall = false
enable_bastion  = false

subnets = {
  firewall = {
    name             = "AzureFirewallSubnet"
    address_prefixes = ["10.0.1.0/26"]
  }

  bastion = {
    name             = "AzureBastionSubnet"
    address_prefixes = ["10.0.2.0/26"]
  }

  gateway = {
    name             = "GatewaySubnet"
    address_prefixes = ["10.0.3.0/27"]
  }

  dns_resolver = {
    name             = "snet-dns-resolver"
    address_prefixes = ["10.0.4.0/28"]

    delegation = {
      name                    = "Microsoft.Network.dnsResolvers"
      service_delegation_name = "Microsoft.Network/dnsResolvers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}
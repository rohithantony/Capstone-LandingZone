resource_group_name = "rg-spoke-prod"
location            = "eastus"

tags = {
  Environment = "prod"
  Project     = "capstone-landing-zone"
  ManagedBy   = "Terraform"
}

virtual_network_name          = "vnet-spoke-prod"
virtual_network_address_space = ["10.3.0.0/16"]

subnets = {
  application = {
    name             = "snet-spoke-prod"
    address_prefixes = ["10.3.1.0/24"]
  }
}

nsg_name = "nsg-spoke-prod"

security_rules = {
  allow_ssh_from_bastion = {
    name                       = "allow-ssh-from-bastion"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.2.0/26"
    destination_address_prefix = "*"
    description                = "Allow SSH from Azure Bastion subnet."
  }

  deny_internet_inbound = {
    name                       = "deny-internet-inbound"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
    description                = "Deny inbound traffic from the Internet."
  }
}

route_table_name = "rt-spoke-prod"

firewall_private_ip   = "10.0.1.4"
enable_firewall_route = false

key_vault_name = "kv-capstone-prod-0001"
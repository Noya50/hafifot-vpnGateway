resource "azurerm_public_ip" "pips" {
  for_each = var.vpnGateway_active_active == true ? tomap({ 0 = true, 1 = true, 2 = true }) : tomap({ 0 = true, 1 = true })

  name                = "gateway-pip-${each.key + 1}-tf"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = var.gateway_pip_allocation_method
  sku                 = var.gateway_pip_sku
  zones               = var.gateway_pip_zones

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

module "pips_diagnostic_setting" {
  for_each = var.vpnGateway_active_active == true ? tomap({ 0 = true, 1 = true, 2 = true }) : tomap({ 0 = true, 1 = true })
  source = "git::https://github.com/Noya50/hafifot-diagnosticSetting.git?ref=main"

  name                       = "${azurerm_public_ip.pips[each.key].name}-diagnostic-setting"
  target_resource_id         = azurerm_public_ip.pips[each.key].id
  log_analytics_workspace_id = var.pips_log_analytics_workspace_id != null ? var.pips_log_analytics_workspace_id : var.log_analytics_workspace_id
}

resource "azurerm_virtual_network_gateway" "this" {
  name                             = var.vpnGateway_name
  location                         = var.location
  resource_group_name              = var.resource_group
  type                             = var.vpnGateway_type
  vpn_type                         = var.vpnGateway_vpn_type
  active_active                    = var.vpnGateway_active_active
  enable_bgp                       = var.vpnGateway_enable_bgp
  sku                              = var.vpnGateway_sku
  private_ip_address_enabled       = var.vpnGateway_private_ip_address_enabled
  edge_zone                        = var.edge_zone
  default_local_network_gateway_id = var.default_local_network_gateway_id
  ip_sec_replay_protection_enabled = var.ip_sec_replay_protection_enabled
  virtual_wan_traffic_enabled      = var.virtual_wan_traffic_enabled

  depends_on = [azurerm_public_ip.pips]

  dynamic "ip_configuration" {
    for_each = azurerm_public_ip.pips
    content {
      name                          = "${ip_configuration.value.name}-config"
      public_ip_address_id          = ip_configuration.value.id
      private_ip_address_allocation = var.ip_configuration_private_ip_address_allocation
      subnet_id                     = var.subnet_id
    }
  }

  vpn_client_configuration {
    address_space        = var.vpn_client_configuration_address_space
    vpn_auth_types       = var.vpn_client_configuration_vpn_auth_types
    vpn_client_protocols = var.vpn_client_configuration_vpn_client_protocols
    aad_tenant           = var.aad_tenant
    aad_audience         = var.aad_audience
    aad_issuer           = var.aad_issuer
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

module "diagnostic_setting" {
  source = "git::https://github.com/Noya50/hafifot-diagnosticSetting.git?ref=main"

  name                          = "${azurerm_virtual_network_gateway.this.name}-diagnostic-setting-tf"
  target_resource_id            = azurerm_virtual_network_gateway.this.id
  log_analytics_workspace_id    = var.log_analytics_workspace_id
}

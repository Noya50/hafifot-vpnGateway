variable "vpnGateway_name" {
  description = "(Required) The name of the vpnGateway resource."
  type        = string
}

variable "resource_group" {
  description = "(Required) The name of the resource group in which the gateway will be created."
  type        = string
}

variable "location" {
  description = "(Required) The location of the gateway."
  type        = string
}

variable "subnet_id" {
  description = "(Required) The id of the GatewaySubnet."
  type        = string
}

variable "vpn_client_configuration_address_space" {
  description = "(Required) The address space out of which IP addresses for vpn clients will be taken."
  type        = list(string)
}

variable "gateway_pip_allocation_method" {
  description = "(Optional) Defines the allocation method for the IP's of the gateway."
  default     = "Static"
  type        = string
  validation {
    condition     = can(regex("^(Static|Dynamic)$", var.gateway_pip_allocation_method))
    error_message = "Invalid allocation method, only allowed values are: 'Static', 'Dynamic'. Default 'Static'"
  }
}

variable "gateway_pip_sku" {
  description = "(Optional) The SKU of the Public IP's of the gateway. "
  type        = string
  default     = "Standard"
}

variable "gateway_pip_zones" {
  description = "(Optional) A collection containing the availability zone to allocate the Public IP in."
  type        = set(string)
  default     = ["1"]
}

variable "vpnGateway_type" {
  description = "(Optional) The type of the gateway."
  default     = "Vpn"
  type        = string
  validation {
    condition     = can(regex("^(Vpn|ExpressRoute)$", var.vpnGateway_type))
    error_message = "Invalid type, only allowed types are: 'Vpn', 'ExpressRoute'. Default 'Vpn'"
  }
}

variable "vpnGateway_vpn_type" {
  description = "(Optional) the vpn type"
  default     = "RouteBased"
  type        = string
  validation {
    condition     = can(regex("^(RouteBased|PolicyBased)$", var.vpnGateway_vpn_type))
    error_message = "Invalid vpn type, only allowed vpn types are: 'RouteBased', 'PolicyBased'. Default 'RouteBased'"
  }
}

variable "vpnGateway_active_active" {
  description = "(Optional) Defines whether the vpn gateway is active active"
  default     = false
  type        = bool
  validation {
    condition     = can(regex("^(true|false)$", var.vpnGateway_active_active))
    error_message = "Invalid value, only allowed values are: 'true' or 'false'. Default 'false'"
  }
}

variable "vpnGateway_enable_bgp" {
  description = "(Optional) Defines whether the bgp is enable"
  default     = false
  type        = bool
  validation {
    condition     = can(regex("^(true|false)$", var.vpnGateway_enable_bgp))
    error_message = "Invalid value, only allowed values are: 'true' or 'false'. Default 'false'"
  }
}

variable "vpnGateway_sku" {
  description = "(Optional) The sku of the vpn"
  default     = "VpnGw2AZ"
  type        = string
}

variable "vpnGateway_private_ip_address_enabled" {
  description = "(Optional) Defines whether the vpn gateway will have a private ip address."
  default     = true
  type        = bool
  validation {
    condition     = can(regex("^(true|false)$", var.vpnGateway_private_ip_address_enabled))
    error_message = "Invalid value, only allowed values are: 'true' or 'false'. Default 'true'"
  }
}

variable "ip_configuration_private_ip_address_allocation" {
  description = "(Optional) Defines how the private IP address of the gateways virtual interface is assigned."
  default     = "Dynamic"
  type        = string
  validation {
    condition     = can(regex("^(Static|Dynamic)$", var.ip_configuration_private_ip_address_allocation))
    error_message = "Invalid allocation method, only allowed values are: 'Static', 'Dynamic'. Default 'Dynamic'"
  }
}

variable "vpn_client_configuration_vpn_auth_types" {
  description = "(Optional) List of the vpn authentication types for the virtual network gateway. The supported values are AAD, Radius and Certificate, default 'AAD'."
  default     = ["AAD"]
  type        = set(string)
}

variable "vpn_client_configuration_vpn_client_protocols" {
  description = "(Optional) List of the protocols supported by the vpn client."
  default     = ["OpenVPN"]
  type        = set(string)
}

variable "aad_tenant" {
  description = "(Optional) AzureAD Tenant URL. Required if authentication type AAd is selected. "
  type        = string
  default     = null
}

variable "aad_audience" {
  description = "(Optional) The client id of the Azure VPN application. Required if authentication type AAd is selected."
  type        = string
  default     = null
}

variable "aad_issuer" {
  description = "(Optional) The STS url for your tenant. Required if authentication type AAd is selected."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the vpn gateway resource."
  type        = map(string)
  default     = {}
}

variable "log_analytics_workspace_id" {
  description = "(Optional) ID of the log analytics workspace to which the diagnostic setting will send the logs of this resource."
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Virtual Network Gateway should exist."
  type        = string
  default     = null
}

variable "default_local_network_gateway_id" {
  description = "(Optional) The ID of the local network gateway through which outbound Internet traffic from the virtual network in which the gateway is created will be routed (forced tunnelling)."
  default     = null
  type        = string
}

variable "ip_sec_replay_protection_enabled" {
  description = "(Optional) Is IP Sec Replay Protection enabled? Defaults to true."
  default     = true
  type        = bool
}

variable "virtual_wan_traffic_enabled" {
  description = "(Optional) Is remote vnet traffic that is used to configure this gateway to accept traffic from remote Virtual WAN networks enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "pips_log_analytics_workspace_id" {
  description = "(Optional) Log analytics workspace for the diagnostic setting of the gateway's pips. If this value is not specified, the log_analytics_workspace_id of the gateway will be used."
  type = string
  default = null
}

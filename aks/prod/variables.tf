variable "subscription_id" {
  type        = string
  description = "Azure Sub"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant"
}

variable "location" {
  type = map(any)
  default = {
    "prod1" = "westus2"
    "prod2" = "westeurope"
  }
}

variable "agent_subnet" {
  type = map(any)
  default = {
    "prod1" = ""
    "prod2" = ""
  }
}

variable "agent_virtual_network_name" {
  type = map(any)
  default = {
    "prod1" = ""
    "prod2" = ""
  }
}

variable "vnet_resource_group" {
  type = map(any)
  default = {
    "prod1" = ""
    "prod2" = ""
  }
}

variable "pod_cidr" {
  default = "10.1.0.0/16"
}

variable "service_cidr" {
  default = "10.0.0.0/16"
}

variable "dns_service_ip" {
  default = "10.0.0.10"
}
variable "env" {
  type = map(any)
  default = {
    "prod1" = "prod"
    "prod2" = "prod"
  }
}

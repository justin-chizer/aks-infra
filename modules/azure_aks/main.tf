data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "agent" {
  name                 = var.agent_subnet
  virtual_network_name = var.agent_virtual_network_name
  resource_group_name  = var.vnet_resource_group
}

data "azurerm_virtual_network" "vnet" {
  name                = var.agent_virtual_network_name
  resource_group_name = var.vnet_resource_group
}

data "azurerm_user_assigned_identity" "mi" {
  name                = var.user_assigned_identity_name
  resource_group_name = var.user_assigned_identity_resource_group
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                            = var.cluster_name
  location                        = data.azurerm_resource_group.rg.location
  resource_group_name             = data.azurerm_resource_group.rg.name
  dns_prefix                      = var.dns_prefix
  kubernetes_version              = var.kubernetes_version
  private_cluster_enabled         = false
  sku_tier                        = var.sku_tier #"Free" # "Paid" for prod
  api_server_authorized_ip_ranges = [""]

  default_node_pool {
    name                = "system"
    vm_size             = var.default_node_pool_vm_size #"Standard_D4as_v4" has cache size of 50 GB
    enable_auto_scaling = var.default_node_pool_enable_auto_scaling
    max_count           = var.default_node_pool_max_count
    min_count           = var.default_node_pool_min_count
    os_disk_type        = "Ephemeral"
    os_disk_size_gb     = var.default_node_pool_os_disk_size_gb #85
    max_pods            = 110
    vnet_subnet_id      = data.azurerm_subnet.agent.id
    type                = "VirtualMachineScaleSets"
  }

  lifecycle {
    ignore_changes = [ default_node_pool[0].node_count ]
}

  network_profile {
    network_plugin     = "kubenet"
    network_policy     = "calico"
    docker_bridge_cidr = "172.17.0.1/16"
    pod_cidr           = var.pod_cidr
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    load_balancer_sku  = "Standard"
  }

  identity {
    type                      = "UserAssigned"
    user_assigned_identity_id = data.azurerm_user_assigned_identity.mi.id
  }

  role_based_access_control {
    azure_active_directory {
       managed                = true
       admin_group_object_ids = [""]
    }
    enabled = true
  }

  tags = {
    environment = var.env
    created_by  = "terraform"
  }
}

resource "azurerm_role_assignment" "aks" {
  scope              = data.azurerm_virtual_network.vnet.id
  role_definition_id = "/subscriptions/${var.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/4d97b98b-1d4f-4787-a291-c67834d212e7" #"4d97b98b-1d4f-4787-a291-c67834d212e7" = Network Contributor
  principal_id       = data.azurerm_user_assigned_identity.mi.principal_id
}
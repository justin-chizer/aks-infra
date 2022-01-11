variable "resource_group_name" {

}

variable "subscription_id" {

}

variable "agent_subnet" {

}

variable "agent_virtual_network_name" {

}

variable "vnet_resource_group" {

}

variable "user_assigned_identity_name" {

}

variable "user_assigned_identity_resource_group" {

}

variable "cluster_name" {

}

variable "dns_prefix" {

}

variable "kubernetes_version" {

}

variable "sku_tier" {
  type        = string
  description = "Possible values are 'Free' and 'Paid' (which includes the Uptime SLA)"
}

variable "default_node_pool_vm_size" {
  description = "Standard_E2as_v4 has cache size of 50 GB"
}

variable "default_node_pool_enable_auto_scaling" {

}

variable "default_node_pool_max_count" {

}

variable "default_node_pool_min_count" {

}

variable "default_node_pool_os_disk_size_gb" {
  description = "Must be greater than 30 but less than the cache of the vm size"
}


variable "pod_cidr" {

}

variable "service_cidr" {
  #default = "10.0.0.0/16"
}

variable "dns_service_ip" {

}

variable "env" {

}
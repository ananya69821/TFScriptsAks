# AKS Input Variables

# SSH Public Key for Linux VMs
variable "ssh_public_key" {
  default = "./aksprodsshkey.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"  
}

# Windows Admin Username for k8s worker nodes
variable "windows_admin_username" {
  type = string
  default = "azureuser"
  description = "This variable defines the Windows admin username k8s Worker nodes"  
}

# Windows Admin Password for k8s worker nodes
variable "windows_admin_password" {
  type = string
  default = "123AnanyaRekha@"
  description = "This variable defines the Windows admin password k8s Worker nodes"  
}

variable "app_gateway_name" {
  default = "appgateway1"
}

variable "aks_service_principal_object_id" {
  default = "fdb0b2ca-dc62-465b-951c-a3660dbf04a4"
}


variable "aks_service_cidr" {
  description = "CIDR notation IP range from which to assign service cluster IPs"
  default     = "10.0.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "DNS server IP address"
  default     = "10.0.0.10"
}

variable "aks_docker_bridge_cidr" {
  description = "CIDR notation IP for Docker bridge."
  default     = "172.17.0.1/16"
}

variable "aks_service_principal_app_id"{
  default = "a2844c0e-f791-4865-8e19-ce2f6c67c26f"
}

variable "aks_service_principal_client_secret"{
  default = "Yqj8Q~PijP8Y0HgRcblqkOYGfHVYoiUlmsgYcaHA"
}

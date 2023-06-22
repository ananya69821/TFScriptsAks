variable "virtual_network_info" {
  type = object({
    name        = string
    addrs       = string
    dns_servers = optional(list(string))
  })
  description = "name and Address space values for Virtual Network"

}

variable "subnet_names" {
    type        = list(object({
      name         = string
      addrs         = string
      subnet_delegation = optional(list(object({
          name = string
          service_delegation = object({
            name = string
            actions = optional(list(string))
          })
      })),[]),
      routes = optional(list(any),[])
      nsg_rules = optional(list(object({
          name = string
          priority = string
          direction = string
          access                     = string
          protocol                   = string
          source_port_range          = string
          destination_port_range     = string
          source_address_prefix      = string
          destination_address_prefix = string
      })),[])

    }))
    description = "Name for subnets and address spaces" 
    default =[]
}



variable "rg_name" {
  type = string
}
variable "rg_location" {
  type = string
}

variable "subresource_names" {
  type        = list(any)
  description = "subresource_names for private service connection"
  default     = []
}




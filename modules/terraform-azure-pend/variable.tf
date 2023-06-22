
variable "rg_name" {
    
}
variable "rg_location" {
    
}

variable "subnet_app_info" {
    type = list(object({
      subnet_name = string
      subnet_id = string
      app_name = string
      app_id = string
      subresource_names = list(string)
    }))
    description = "SubnetIds and Web app Ids" 
    default =[]
}

variable "subresource_names" {
  type = list(any)
  description = "subresource_names for private service connection"
  default = []
}
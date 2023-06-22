
variable "subnet_app_info" {
    type = object({
      subnet_name = string
      subnet_id = string
      app_name = string
      app_id = string
      subresource_names = list(string)
      rg_location = string
      rg_name = string
    })
    description = "SubnetIds and Web app Ids" 
    
}

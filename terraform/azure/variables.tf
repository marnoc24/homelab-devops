variable "location" {
  type    = string
  default = "switzerlandnorth"
}

variable "prefix" {
  type    = string
  default = "swisslab"
}

variable "vm_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/azure_homelab.pub"
}

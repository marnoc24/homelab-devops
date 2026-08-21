output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "vm_public_ip" {
  value = azurerm_public_ip.main.ip_address
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/azure_homelab ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}

output "http_url" {
  value = "http://${azurerm_public_ip.main.ip_address}"
}

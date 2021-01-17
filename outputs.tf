output "ws_names" {
  #value = azurerm_container_registry.mis_poc_acr.id
   value = tolist([ for ws_names in setunion(var.workspace_common, var.workspace_net, var.workspace_inf) : ws_names])
}

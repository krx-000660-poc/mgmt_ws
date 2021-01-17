variable "workspace_common" {
  type = set(string)
  default = [
    "misO_mgmt_variables",
    "misO_mgmt_teams", // mis-poc-vnet용 ws
  ]
}

variable "workspace_net" {
  type = set(string)
  default = [
    "misO_KC_nw_vnet", // mis-poc-vnet용 ws 
    "misO_KC_nw_vnet_peering", // mis-poc-vnet용 ws 
  ]
}

variable "workspace_inf" {
  type = set(string)
  default = [
    "misO_KC_inf_aks",  //
    "misO_KC_inf_acr",  //
    "misO_KC_inf_eai",  //
    "misO_KC_inf_hp",   //
    "misO_KC_inf_fscp", //
    "misO_KC_inf_rsv",  //
    "misO_KC_inf_rsvbp",
    "misO_KC_inf_mgmt", //
    "misO_KC_inf_cloudconn", //
  ]
}

#variable "workspace_db" {
#  type = set(string)
#  default = [
#    "misO_KC_oracle",          //
#    "misO_KC_aurora",          //
#  ]
#}

resource "tfe_workspace" "mis_mgmt_workspace" {
  #for_each              = setunion(var.workspace_net,var.workspace_inf,var.workspace_db)
  for_each              = setunion(var.workspace_common, var.workspace_net, var.workspace_inf)
  name                  = each.key
  organization          = var.core.org
  auto_apply            = false
  file_triggers_enabled = false
  operations            = true
  terraform_version     = "0.14.4"
  lifecycle {
    ignore_changes = [
      working_directory,
      vcs_repo
    ]
  }
}

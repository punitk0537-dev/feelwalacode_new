# resource "azurerm_storage_account" "sts" {
#   for_each=var.sts
#   name                     = each.value.sa_name
#   resource_group_name      = each.value.sa_resource_group_name
#   location                 = each.value.sa_location
#   account_tier             = each.value.sa_account_tier 
#   account_replication_type = each.value.sa_account_replication_type

#   tags = {
#     environment = "staging"
#   }
# }
module "rgs" {

  source = "../../modules/azurerm_rg"
  rgs    = {
    dev={
        name="punit-dev-rg"
        location="centralindia"
         
    }
  }
}
module "vnets" {
  depends_on = [module.rgs]
  source     = "../../modules/azurerm_vnet"

  vnets = {
    dev ={
        name= "punit-dev-vnet"
        location= "centralindia"
        resource_group_name = "punit-dev-rg"
        address_space = ["10.0.0.0/16"]
    }
  }
}


module "subnets" {
  depends_on = [module.vnets]
  source     = "../../modules/azurerm_subnet"

  subnets = {
    dev ={
        name = "punit-dev-sunet"
        resource_group_name = "punit-dev-rg"
        virtual_network_name = "punit-dev-vnet"
        address_prefixes = ["10.0.1.0/24"]
    }

      BastionSubnet ={
        name = "AzureBastionSubnet"
        resource_group_name = "punit-dev-rg"
        virtual_network_name = "punit-dev-vnet"
        address_prefixes = ["10.0.2.0/24"]
    }
  }
}
module "bastion" {
    depends_on = [ module.subnets ]
    source = "../../modules/azurerm_bastion"
    bastion = {
        dev = {
            bastion_name = "punit-dev-bastion"
            resource_group_name = "punit-dev-rg"
            location = "centralindia"
            virtual_network_name = "punit-dev-vnet"
            subnet_name = "AzureBastionSubnet"
            public_ip_name = "punit-dev-bastion-pip"
            
        }
    }
  
}
module "vm" {
    depends_on = [ module.subnets ]
    source = "../../modules/azurerm_vm"
    virtual_machine = {
        dev ={
            
             virtual_network_name="punit-dev-vnet"
             resource_group_name ="punit-dev-rg"
             subnet_name = "punit-dev-sunet"
             nic_name = "punit-dev-nic"
             location = "centralindia"
             vm_size = "Standard_B2ats_v2"
             vm_name ="punit-dev-vm"

        }
    }


  
}

# module "sa" {

#   source = "../../modules/azurerm_stoarage_account"
#   sts    = {
#     dev={
#         name="punit-dev-sa"
#         location="centralindia"
         
#     }
#   }
# }

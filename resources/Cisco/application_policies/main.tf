module "application_policies" {
  source              = "../../../modules/Cisco/Application_Policies"
  application_profile = {
    intranet = {
      tdn = "uni/vmmp-VMware/dom-aci_terraform_lab"
    }
  }
  bridge_domain = {
    prod_bd = {
      tenant_dn              = "terraform-tenant"
      optimize_wan_bandwidth = "yes"
      ep_move_detect_mode    = "enable"
    }
  }
  contract = {
    https = {},
    sql   = {}
  }
  filter = {
    https = {
      prot        = "tcp"
      d_from_port = "443"
      d_to_port   = "443"
    },
    sql = {
      prot        = "tcp"
      d_from_port = "1433"
      d_to_port   = "1433"
    }
  }
  subnet = {
    "10.10.101.1/24" = {
      parent_dn = "prod_bd"
    }
  }
  tenant = {
    terraform-tenant = {}
  }
  vrf = {
    prod_vrf = {
      tenant_dn          = "terraform-tenant"
      bd_enforced_enable = "yes"
    }
  }
}
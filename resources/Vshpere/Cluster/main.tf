module "tag_category" {
  source       = "../../../modules/vsphere/Inventory/Tag_Category"
  tag_category = {}
}

module "tags" {
  source = "../../../modules/vsphere/Inventory/Tag"
  tag    = {}
}

module "datacenter" {
  source = "../../../modules/vsphere/Inventory/Datacenter"
  datacenter = {
    dc-01 = {
      tags = module.tags[*].tag
    }
  }
}

module "host" {
  source = "../../../modules/vsphere/Management/Host"
  host = {
    host01 = {
      datacenter_id = module.datacenter[*].datacenter
      lockdown      = "normal"
      tags          = module.tags[*].tag
    }
  }
}

module "cluster" {
  source = "../../../modules/vsphere/Management/Compute_Cluster"
  cluster = {
    cluster01 = {
      datacenter_id = module.datacenter[*].datacenter
      host_system_ids = module.host[*].host
    }
    drs = {
      drs_enabled = true
      drs_automation_level = "fullyAutomated"
    }
    ha = {
      ha_enabled = true
    }
  }
}
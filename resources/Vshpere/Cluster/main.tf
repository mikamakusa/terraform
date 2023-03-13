module "License" {
  source = "../../../modules/vsphere/Administration/License"
  license = ""
  labels = {
    label1 = "label1"
  }
}

module "custom_attribute" {
  source = "../../../modules/vsphere/Inventory/Custom_Attribute"
  custom_attribute = {
    attribute-1 = {
      object_managed_type = "VirtualMachines"
    },
    attribute-2 = {
      object_managed_type = "Datacenters"
    }
  }
}

module "tag_category" {
  source       = "../../../modules/vsphere/Inventory/Tag_Category"
  tag_category = {
    category-1 = {
      cardinality = "SINGLE"
      associable_types = [
      "VirtualMachine",
        "Datastore"
      ]
    }
  }
}

module "tags" {
  source = "../../../modules/vsphere/Inventory/Tag"
  tag    = {
    tag_category = module.tag_category[1].tag_category
  }
}

module "datacenter" {
  source = "../../../modules/vsphere/Inventory/Datacenter"
  datacenter = {
    dc-01 = {
      tags = module.tags[*].tag
    }
  }
}

module "folder" {
  source = "../../../modules/vsphere/Inventory/Folder"
  folder = {
    path = "terraform"
    type = "datacenter"
    datacenter_id = module.datacenter[*].datacenter
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
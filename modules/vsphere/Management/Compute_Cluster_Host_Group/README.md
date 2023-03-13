# VSphere Compute Cluster Host Group Terraform module documentation

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vsphere"></a> [vsphere](#requirement\_vsphere) | 2.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | 2.3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_compute_cluster_host_group.compute_cluster_host_group](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/compute_cluster_host_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_host_group"></a> [host\_group](#input\_host\_group) | n/a | <pre>map(object({<br>    compute_cluster_id = string<br>    host_system_ids    = optional(list(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host_group"></a> [host\_group](#output\_host\_group) | n/a |

## Usage
### main.tf / No host_system_ids
```hcl
module "cluster" {
  source = "../../../modules/vsphere/Management/Compute_Cluster"
  cluster = {
    cluster01 = {
      datacenter_id     = module.datacenter[*].datacenter
      folder            = "/servers/"
      tags              = module.tags[*].tag
      custom_attributes = module.custom_attribute[*].custom_attribute
    }
    host_management = {
      host_system_ids           = module.host[*].host
      force_evacute_on_destroy  = true
    }
    dpm = {
      enabled           = true
      automation_level  = "Automated"
    }
    drs = {
      enabled           = true
      automation_level  = "fullyAutomated"
    }
    ha = {
      enabled = true
      host = {
        monitoring = "enabled"
      }
    }
    proactive = {
      enabled               = true
      automation_level      = "Automated"
      moderate_remediation  = "MaintenanceMode"
    }
  }
}

module "cluster_host_group" {
  source = "../../../modules/vsphere/Management/Compute_Cluster_Host_Group"
  host_group = {
    group-1 = {
      compute_cluster_id = module.cluster[*].vsphere_cluster
    }
  }
}
```

### main.tf / No host_system_ids
```hcl
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
      datacenter_id     = module.datacenter[*].datacenter
      folder            = "/servers/"
      tags              = module.tags[*].tag
      custom_attributes = module.custom_attribute[*].custom_attribute
    }
    host_management = {
      host_system_ids           = module.host[*].host
      force_evacute_on_destroy  = true
    }
    dpm = {
      enabled           = true
      automation_level  = "Automated"
    }
    drs = {
      enabled           = true
      automation_level  = "fullyAutomated"
    }
    ha = {
      enabled = true
      host = {
        monitoring = "enabled"
      }
    }
    proactive = {
      enabled               = true
      automation_level      = "Automated"
      moderate_remediation  = "MaintenanceMode"
    }
  }
}

module "cluster_host_group" {
  source = "../../../modules/vsphere/Management/Compute_Cluster_Host_Group"
  host_group = {
    group-1 = {
      compute_cluster_id = module.cluster[*].vsphere_cluster
      host_system_ids = module.host[*].host
    }
  }
}
```
# Virtual Machine Vsphere Terraform module documentation

## Usage
### module declaration
#### Virtual Machine creation
```hcl
module "vm" {
  source        = "../../../modules/vsphere/Virtual_Machine/Virtual_Machine"
  datacenter    = var.datacenter
  datastore     = var.datastore
  cluster       = var.cluster
  network       = var.network
  vm            = {
    original-1 = {
      num_cpus   = 1
      memory     = 1024
      guest_id   = "other3xLinux64Guest"
      disk_value = "disk0"
      disk_size  = 20
    }
  }
}
```

#### Linux Virtual Machine cloning
```hcl
module "vm" {
  source     = "../../../modules/vsphere/Virtual_Machine/Virtual_Machine"
  datacenter = var.datacenter
  datastore  = var.datastore
  cluster    = var.cluster
  network    = var.network

  clone_linux = {
    clone-1 = {
      domaine      = var.domain
      ipv4_address = var.ipv4_address
      ipv4_netmask = var.ipv4_netmask
    }
  }
}
```

#### Windows Virtual Machine cloning
```hcl
module "vm" {
  source        = "../../../modules/vsphere/Virtual_Machine/Virtual_Machine"
  datacenter = var.datacenter
  datastore  = var.datastore
  cluster    = var.cluster
  network    = var.network
  
  clone_windows = {
    clone-1 = {
      ipv4_address = var.ipv4_address
      ipv4_netmask = var.ipv4_netmask
    }
  }
}
```

#### Deploying a Virtual Machine from Remote OVF/OVA file
```hcl
module "vm" {
  source        = "../../../modules/vsphere/Virtual_Machine/Virtual_Machine"
  datacenter    = var.datacenter
  datastore     = var.datastore
  cluster       = var.cluster
  network       = var.network
  
  ovf_template = [
    {
      name              = var.template_name
      disk_provisioning = "thin"
      remote_ovf_url    = "https://download3.vmware.com/software/vmw-tools/nested-esxi/Nested_ESXi7.0u3_Appliance_Template_v1.ova"
    }
  ]
  from_ovf = {
    vm-from-ovf = {
      properties = {
        "guestinfo.hostname"  = "nested-esxi-01.example.com",
        "guestinfo.ipaddress" = "172.16.11.101",
        "guestinfo.netmask"   = "255.255.255.0",
        "guestinfo.gateway"   = "172.16.11.1",
        "guestinfo.dns"       = "172.16.11.4",
        "guestinfo.domain"    = "example.com",
        "guestinfo.ntp"       = "ntp.example.com",
        "guestinfo.password"  = "VMware1!",
        "guestinfo.ssh"       = "True"
      }
    }
  }
}
```

#### Deploying a Virtual Machine from local OVF/OVA file
```hcl
module "vm" {
  source        = "../../../modules/vsphere/Virtual_Machine/Virtual_Machine"
  datacenter    = var.datacenter
  datastore     = var.datastore
  cluster       = var.cluster
  network       = var.network
  
  ovf_template = [
    {
      name              = var.template_name
      disk_provisioning = "thin"
      local_ovf_path    = "/Volume/Storage/OVA/Nested_ESXi7.0u3_Appliance_Template_v1.ova"
    }
  ]
  from_ovf = {
    vm-from-ovf = {
      properties = {
        "guestinfo.hostname"  = "nested-esxi-01.example.com",
        "guestinfo.ipaddress" = "172.16.11.101",
        "guestinfo.netmask"   = "255.255.255.0",
        "guestinfo.gateway"   = "172.16.11.1",
        "guestinfo.dns"       = "172.16.11.4",
        "guestinfo.domain"    = "example.com",
        "guestinfo.ntp"       = "ntp.example.com",
        "guestinfo.password"  = "VMware1!",
        "guestinfo.ssh"       = "True"
      }
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.4.5 |
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
| [vsphere_virtual_machine.clone_linux](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/virtual_machine) | resource |
| [vsphere_virtual_machine.clone_windows](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/virtual_machine) | resource |
| [vsphere_virtual_machine.from_ovf](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/virtual_machine) | resource |
| [vsphere_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/virtual_machine) | resource |
| [vsphere_compute_cluster.cluster](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/compute_cluster) | data source |
| [vsphere_datacenter.datacenter](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/datacenter) | data source |
| [vsphere_datastore.datastore](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/datastore) | data source |
| [vsphere_datastore_cluster.datastore_cluster](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/datastore_cluster) | data source |
| [vsphere_folder.folder](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/folder) | data source |
| [vsphere_host.host](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/host) | data source |
| [vsphere_network.network](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/network) | data source |
| [vsphere_ovf_vm_template.ovf_template](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/ovf_vm_template) | data source |
| [vsphere_storage_policy.storage_policy](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/storage_policy) | data source |
| [vsphere_tag.tag](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/tag) | data source |
| [vsphere_tag_category.tag_category](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/tag_category) | data source |
| [vsphere_virtual_machine.template](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/data-sources/virtual_machine) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clone_linux"></a> [clone\_linux](#input\_clone\_linux) | For Linux - Building on the above example, the below configuration creates a virtual machine by cloning it from a template, fetched using the vsphere\_virtual\_machine data source. This option allows you to locate the UUID of the template to clone, along with settings for network interface type, SCSI bus type, and disk attributes. | <pre>map(object({<br>    domain       = string<br>    ipv4_address = optional(string)<br>    ipv4_netmask = optional(number)<br>  }))</pre> | `{}` | no |
| <a name="input_clone_windows"></a> [clone\_windows](#input\_clone\_windows) | For Windows - Building on the above example, the below configuration creates a virtual machine by cloning it from a template, fetched using the vsphere\_virtual\_machine data source. This option allows you to locate the UUID of the template to clone, along with settings for network interface type, SCSI bus type, and disk attributes. | <pre>map(object({<br>    computer_name = string<br>    ipv4_address  = optional(string)<br>    ipv4_netmask  = optional(number)<br>  }))</pre> | `{}` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Name of the Cluster | `string` | `""` | no |
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | Name of the datacenter | `string` | `""` | no |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | Name of the datastore to deploy the virtual machine | `string` | `""` | no |
| <a name="input_datastore_cluster"></a> [datastore\_cluster](#input\_datastore\_cluster) | Name of the datastore cluster to deploy the virtual machine | `string` | `""` | no |
| <a name="input_folder"></a> [folder](#input\_folder) | Name of the folder in which the virtual machine will be stored | `string` | `""` | no |
| <a name="input_from_ovf"></a> [from\_ovf](#input\_from\_ovf) | Variable to instance in order to deploy a virtual machine from OVA/OVF file. | <pre>map(object({<br>    vapp = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | Number of virtual machine needed to be deployed | `number` | `1` | no |
| <a name="input_network"></a> [network](#input\_network) | n/a | `map(list(string))` | `{}` | no |
| <a name="input_ovf_template"></a> [ovf\_template](#input\_ovf\_template) | n/a | <pre>list(object({<br>    name              = string<br>    disk_provisioning = optional(string)<br>    remote_ovf_url    = optional(string)<br>    local_ovf_url     = optional(string)<br>    ovf_network_map   = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_storage_policy"></a> [storage\_policy](#input\_storage\_policy) | The storage policy to be sassigned to the virtual machine home directory | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The name of the tags to attach to the resource | `map(any)` | `null` | no |
| <a name="input_tags_ids"></a> [tags\_ids](#input\_tags\_ids) | The ids of the tags to attache to the resource | `list(any)` | `null` | no |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | Name of the template for the VM to be deployed | `string` | `""` | no |
| <a name="input_vm"></a> [vm](#input\_vm) | n/a | <pre>map(object({<br>    num_cpus   = optional(number)<br>    memory     = optional(number)<br>    guest_id   = optional(string)<br>    disk_size  = optional(number)<br>    disk_value = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_vsphere_host"></a> [vsphere\_host](#input\_vsphere\_host) | Vsphere host on which the template is store or on which the virtual machine will be deployed | `string` | `""` | no |

## Outputs

No outputs.

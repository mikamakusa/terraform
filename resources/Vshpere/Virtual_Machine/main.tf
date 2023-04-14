module "revproxy" {
  source        = "../../../modules/vsphere/Virtual_Machine/Virtual_Machine"
  clone         = {}
  disk          = {}
  domain        = ""
  datacenter    = ""
  template_name = ""
  general_options = {
    memory             = ""
    num_cpus           = ""
  }
  linux         = true
  resource_pool = ""
  vmname        = "revproxy"
  windows       = false
}
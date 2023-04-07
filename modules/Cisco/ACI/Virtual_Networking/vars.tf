variable "vmm_domain" {
  type = map(object({
    provider_profile_dn = string
    access_mode         = optional(string)
    annotation          = optional(string)
    arp_learning        = optional(string)
    enable_ave          = optional(string)
    ave_time_out        = optional(string)
    config_infra_pg     = optional(string)
    ctrl_knob           = optional(string)
    delimiter           = optional(string)
    enable_tag          = optional(string)
    enable_vm_folder    = optional(string)
    encap_mode          = optional(string)
    enf_pref            = optional(string)
    ep_inventory_type   = optional(string)
    ep_ret_time         = optional(string)
    hv_avail_monitor    = optional(string)
    mcast_addr          = optional(string)
    mode                = optional(string)
    name_alias          = optional(string)
    pref_encap_mode     = optional(string)
  }))

  validation {
    condition     = contains(["Microsoft", "CloudFoundry", "Openshift", "Openstack", "VMware", "Kubernetes", "Redhat"], var.vmm_domain.provider_profile_dn)
    error_message = "Allowed values : \"Microsoft\", \"CloudFoundry\", \"Openshift\", \"Openstack\", \"VMware\", \"Kubernetes\", \"Redhat\"."
  }

  validation {
    condition     = contains(["read-write", "read-only"], var.vmm_domain.access_mode)
    error_message = "Allowed values : \"read-write\", \"read-only\"."
  }

  validation {
    condition     = contains(["enabled", "disabled"], var.vmm_domain.arp_learning)
    error_message = "Allowed values : \"enabled\", \"disabled\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.config_infra_pg)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["epDpVerify", "none"], var.vmm_domain.ctrl_knob)
    error_message = "Allowed values : \"epDpVerify\", \"none\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.enable_tag)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.enable_ave)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.enable_vm_folder)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["unknown", "vlan", "vxlan"], var.vmm_domain.encap_mode)
    error_message = "Allowed values : \"unknown\", \"vlan\", \"vxlan\"."
  }

  validation {
    condition     = contains(["hw", "sw", "unknown"], var.vmm_domain.enf_pref)
    error_message = "Allowed values : \"hw\", \"sw\", \"unknown\"."
  }

  validation {
    condition     = contains(["none", "on-link"], var.vmm_domain.ep_inventory_type)
    error_message = "Allowed values : \"none\", \"on-link\"."
  }

  validation {
    condition     = contains(["yes", "no"], var.vmm_domain.hv_avail_monitor)
    error_message = "Allowed values : \"yes\", \"no\"."
  }

  validation {
    condition     = contains(["default", "n1kv", "unknown", "ovs", "k8s", "cf", "openshift"], var.vmm_domain.mode)
    error_message = "Allowed values : \"default\", \"n1kv\", \"unknown\", \"ovs\", \"k8s\", \"cf\", \"openshift\"."
  }

  validation {
    condition     = contains(["unspecified", "vlan", "vxlan"], var.vmm_domain.pref_encap_mode)
    error_message = "Allowed values : \"unspecified\", \"vlan\", \"vxlan\"."
  }

  validation {
    condition     = var.vmm_domain.ave_time_out >= 10 && var.vmm_domain.ave_time_out <= 300
    error_message = "Allowed range value : 10 to 300."
  }

  validation {
    condition     = var.vmm_domain.ep_ret_time >= 0 && var.vmm_domain.ep_ret_time <= 600
    error_message = "Allowed range value : 0 to 600."
  }
}

variable "vswitch_policy" {
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name_alias  = optional(string)
  }))
}

variable "vmm_controller" {
  type = map(object({
    host_or_ip          = string
    root_cont_name      = string
    annotation          = optional(string)
    dvs_version         = optional(string)
    inventory_trig_st   = optional(string)
    mode                = optional(string)
    msft_config_err_msg = optional(string)
    msft_config_issues  = optional(list(string))
    n1kv_stats_mode     = optional(string)
    port                = optional(string)
    scope               = optional(string)
    stats_mode          = optional(string)
    seq_num             = optional(string)
    vxlan_depl_pref     = optional(string)
  }))

  validation {
    condition     = contains(["5.1", "5.5", "6.0", "6.5", "6.6", "7.0", "unmanaged"], var.vmm_controller.dvs_version)
    error_message = "Allowed values : \"5.1\", \"5.5\", \"6.0\", \"6.5\", \"6.6\", \"7.0\" and \"unmanaged\"."
  }

  validation {
    condition     = contains(["autoTriggered", "triggered", "untriggered"], var.vmm_controller.inventory_trig_st)
    error_message = "Allowed values : \"autoTriggered\", \"triggered\", \"untriggered\"."
  }

  validation {
    condition     = contains(["cf", "default", "k8s", "n1kv", "nsx", "openshift", "ovs", "rancher", "rhev", "unknown"], var.vmm_controller.mode)
    error_message = "Allowed values : \"cf\", \"default\", \"k8s\", \"n1kv\", \"nsx\", \"openshift\", \"ovs\", \"rancher\", \"rhev\", \"unknown\"."
  }

  validation {
    condition     = contains(["aaacert-invalid", "duplicate-mac-in-inventory", "duplicate-rootContName", "invalid-object-in-inventory", "invalid-rootContName", "inventory-failed", "missing-hostGroup-in-cloud", "missing-rootContName", "not-applicable", "zero-mac-in-inventory"], var.vmm_controller.msft_config_issues)
    error_message = "Allowed values : \"aaacert-invalid\", \"duplicate-mac-in-inventory\", \"duplicate-rootContName\", \"invalid-object-in-inventory\", \"invalid-rootContName\", \"inventory-failed\", \"missing-hostGroup-in-cloud\", \"missing-rootContName\", \"not-applicable\", \"zero-mac-in-inventory\"."
  }

  validation {
    condition     = contains(["disabled", "enabled", "unknown"], var.vmm_controller.n1kv_stats_mode)
    error_message = "Allowed values : \"disabled\", \"enabled\", \"unknown\"."
  }

  validation {
    condition     = contains(["MicrosoftSCVMM", "cloudfoundry", "iaas", "kubernetes", "network", "nsx", "openshift", "openstack", "rhev", "unmanaged", "vm"], var.vmm_controller.scope)
    error_message = "Allowed values : \"MicrosoftSCVMM\", \"cloudfoundry\", \"iaas\", \"kubernetes\", \"network\", \"nsx\", \"openshift\", \"openstack\", \"rhev\", \"unmanaged\", \"vm\"."
  }

  validation {
    condition     = contains(["disabled", "enabled", "unknown"], var.vmm_controller.stats_mode)
    error_message = "Allowed values : \"disabled\", \"enabled\", \"unknown\"."
  }

  validation {
    condition     = contains(["nsx", "vxlan"], var.vmm_controller.vxlan_depl_pref)
    error_message = "Allowed values : \"nsx\", \"vxlan\"."
  }
}

variable "vmm_credential" {
  type = map(object({
    annotation  = optional(string)
    description = optional(string)
    name_alias  = optional(string)
    pwd         = optional(string)
    usr         = optional(string)
  }))
}

variable "relation_vmm_rs_vswitch_exporter_pol" {
  type = object({
    active_flow_time_out = optional(string)
    idle_flow_time_out   = optional(string)
    sampling_rate        = optional(string)
    target_dn            = optional(string)
  })
  default = {}
}

variable "uplink_names" {
  type = list(string)
}
variable "tenant" {
  type        = string
  description = "Tenant name to recover the id for the vrf data source"
}

variable "vrf_name" {
  type        = string
  description = "Name of the object vrf - needed for the ACI Any object to be created"
}

variable "description" {
  type        = string
  default     = null
  description = "Description of the ANY object - Optional"
}

variable "annotation" {
  type        = string
  default     = null
  description = "Annotation of the ANY Object - Optional"
}

variable "match_t" {
  type        = string
  default     = "AtleastOne"
  description = "Represents the provider label match criteria - Optional"

  validation {
    condition     = contains(["All", "None", "AtmostOne", "AtleastOne"], var.match_t)
    error_message = "Allowed values are 'All', 'None', 'AtmostOne' and 'AtleastOne'."
  }
}

variable "name_alias" {
  type        = string
  default     = null
  description = "Name alias of the Any Object - Optional"
}

variable "pref_gr_memb" {
  type        = string
  default     = "disabled"
  description = "Represents parameter used to determine if EPgs can be divided in a the context can be divided into two subgroups"

  validation {
    condition     = contains(["disabled", "enabled"], var.pref_gr_memb)
    error_message = "Allowed values are 'disabled' and 'enabled'."
  }
}